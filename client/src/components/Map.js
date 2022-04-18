import React, { Component } from 'react';
import "../Map.css";
import PropTypes from 'prop-types';
import SideDrawer from "./SideDrawer";
import SDPSticker from "./SDPSticker";
import remoteFunctions from '../remote';
import bingMapsAPI from '../modules/bingMapAPI';
import {quantileRankSorted} from 'simple-statistics';
const _ = require("lodash");

class Map extends Component {
  constructor(props) {
    super(props);
    const prevMonth = new Date();
    prevMonth.setMonth(prevMonth.getMonth() - 1);
    this.state = {
      endDate: new Date(),
      startDate: prevMonth,
      ready: false,
      utilTypes: [],
      usageData: [],
      buildings: [],
      usageBounds: {},
      map: React.createRef(),
    };
    this.boundStart = this.modifyStartDate.bind(this);
    this.boundEnd = this.modifyEndDate.bind(this);
    this.boundUtil = this.modifyUtilTypes.bind(this);
  }

  // Create a function to modify start date state.
  modifyStartDate(value) {
    this.setState({ startDate: value });
  }

  // Provide a function for our functional components to modify state.
  modifyEndDate(value) {
    this.setState({ endDate: value });
  }

  // Create function to modify utility types
  modifyUtilTypes(value) {
    this.setState({ utilTypes: value });
  }

  /**
   * Updates the map usage with new start/end date.
   * @param {*} startDate - New start date
   * @param {*} endDate - New end date.
   * @param {*} utilTypes - New utility types
   */
  updateMapUsage = async (startDate, endDate) => {
    let buildingsResponse = await remoteFunctions.getBuildings();
    let buildings = {};

    // Make building point to buildingCode -> building
    for (const buildingR of buildingsResponse) {
      buildings[buildingR.buildingCode] = buildingR;
      buildingR.usages = {};
    }

    // Get usages in date range.
    const responseJson = await remoteFunctions.getUsage(
      startDate,
      endDate,
    );

    // Set initial min and max for utilities
    let usageData = {};
    this.setState({usageBounds: {}});
    this.state.utilTypes.forEach((utility) => {
      usageData[utility] = [];
      let usageInfo = {
        min: 0,
        max: 0,
      };
      let newUsageBounds = this.state.usageBounds;
      newUsageBounds[utility] = usageInfo;
      this.setState({usageBounds: newUsageBounds});
    });

    // Goes through every key in the date range
    for (const key of Object.keys(responseJson)) {
      for (const usages of responseJson[key]) {
        const buildingCode = usages.building.buildingCode;

        let building = buildings[buildingCode];
        if (building) {
          if (building.usages[key]) {
            building.usages[key].usage += usages.utilityUsage;
            building.usages[key].cost += usages.cost;
          } else {
            building.usages[key] = {
              usage: usages.utilityUsage,
              cost: usages.cost,
            };
          }
          usageData[key].push(usages.utilityUsage);
        }
      }
    }

    // Sets state.
    this.setState({ buildings: buildings });
    this.createDescriptions(buildings);
  };

  componentDidUpdate(prevProps, prevState) {
    // This method can be called before mounting so we need to make sure app is ready
    if (this.state.ready) {
      if (
        prevState.startDate.getTime() !== this.state.startDate.getTime() ||
        prevState.endDate.getTime() !== this.state.endDate.getTime()
      ) {
        this.state.map.current.entities.clear();
        this.updateMapUsage(this.state.startDate, this.state.endDate);
      } else if (prevState.utilTypes !== this.state.utilTypes) {
        this.state.map.current.entities.clear();
        this.createDescriptions();
      }
    }
  }

  // Helper method to determine pin colors
  between(x, min, max) {
    return x >= min && x <= max;
  }

  // Adds utility usage to building description
  createDescriptions() {
    // Create a clone of our initial buildings state
    let buildingsCopy = _.cloneDeep(this.state.buildings);
    //this.removeOutliers(buildingsCopy);
    for (const bCode of Object.keys(this.state.buildings)) {
      let building = buildingsCopy[bCode];
      let usages = building.usages;
      building.usageDesc = "";
      building.color = "gray";
      
      // Determines description and color based off id.
      for (const filteredUsage of this.state.utilTypes) {
        if (usages[filteredUsage]) {
          let usage = usages[filteredUsage];
          let usageRank = quantileRankSorted(this.state.usageData[filteredUsage], usage.usage);
          
          // Determine color
          if (usageRank <= 0.2) {
            building.color = "#0486D8";
          } else if (this.between(usageRank, 0.2, 0.4)) {
            building.color = "#83B347";
          } else if (this.between(usageRank, 0.4, 0.6)) {
            building.color = "#ffbd28";
          } else if (this.between(usageRank, 0.6, 0.8)) {
            building.color = "#E87121";
          } else if (this.between(usageRank, 0.8, 0.9)) {
            building.color = "#d62828";
          } else if (this.between(usageRank, 0.9, 1)) {
            building.color = "#8B0000";
          }

          // Determines description based off id.
          switch (filteredUsage) {
            case 1:
              building.usageDesc += `Natural Gas: ${usage.usage} kBTU <br/>`;
              break;
            case 2:
              building.usageDesc += `Electric: ${usage.usage} kBTU <br/>`;
              break;
            case 3:
              building.usageDesc += `Steam: ${usage.usage} kBTU <br/>`;
              break;
            case 4:
              building.usageDesc += `Geothermal: ${usage.usage} kBTU <br/>`;
              break;
            case 5:
              building.usageDesc += `Solar: ${usage.usage}\n kBTU <br/>`;
              break;
          }
        }
      }
    }
    this.createPins(buildingsCopy);
  }

  // Adds buildings from buildingData to the map by creating a location, pin, infobox
  // and event handler for each building. Infobox displays each building's usage info
  createPins(buildings) {
    // Create empty array for building pins and info boxes
    var pinArray = [];
    var infoBoxArray = [];
    for (const key of Object.keys(buildings)) {
      var building = buildings[key];
      let location;
      if (building.xCoord != null && building.yCoord != null) {
        location = new window.Microsoft.Maps.Location(
          building.xCoord,
          building.yCoord
        );
      }
      var pin;
      var infoBox;

      if (location) {
        // If there is utility data for the building add it to the info box and color the pin
        if (Object.keys(building.usageDesc).length > 0) {
          pin = new window.Microsoft.Maps.Pushpin(location, {
            color: building.color,
          });
          infoBox = new window.Microsoft.Maps.Infobox(location, {
            title: building.buildingName,
            description: building.usageDesc,
            visible: false,
          });
          pinArray.push(pin);
          infoBoxArray.push(infoBox);
        }
      }
    }
    // Create event handler for each pin/infobox and add them to the map
    for (let i = 0; i < pinArray.length; i++) {
      window.Microsoft.Maps.Events.addHandler(
        pinArray[i],
        "click",
        function () {
          infoBoxArray[i].setOptions({ visible: true });
        }
      );
      infoBoxArray[i].setMap(this.state.map.current);
      this.state.map.current.entities.push(pinArray[i]);
    }
  }

  async componentDidMount() {
    const mapRef = document.getElementById(this.props.id);
    this.state.map.current = await bingMapsAPI.waitGenerateMap(
      window,
      document,
      process.env.REACT_APP_API_KEY,
      mapRef
    );
    const buildings = await remoteFunctions.getBuildings();
    this.setState({ buildings: buildings });
    this.updateMapUsage(this.state.startDate, this.state.endDate);
    this.setState({ready: true});
  }
  render() {
    return (
      <>
        <SideDrawer
          startDate={this.state.startDate}
          setStartDate={this.boundStart}
          endDate={this.state.endDate}
          setEndDate={this.boundEnd}
          setUtilTypes={this.boundUtil}
        />
        <div id={this.props.id} ref={this.state.map}>
          <SDPSticker />
        </div>
      </>
    );
  }
}

Map.propTypes = {
    id: PropTypes.string,
};

export default Map;