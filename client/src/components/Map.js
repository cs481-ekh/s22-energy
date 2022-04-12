import React, { Component } from 'react';
import "../Map.css";
import PropTypes from 'prop-types';
import SideDrawer from "./SideDrawer";
import SDPSticker from "./SDPSticker";
import remoteFunctions from '../remote';
import bingMapsAPI from '../modules/bingMapAPI';
const _ = require("lodash");

class Map extends Component {
  constructor(props) {
    super(props);
    const prevMonth = new Date();
    prevMonth.setMonth(prevMonth.getMonth() - 1);
    this.state = {
      endDate: new Date(),
      startDate: prevMonth,
      utilTypes: [],
      usageData: [],
      buildings: [],
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
  updateMapUsage = async (startDate, endDate, utilTypes) => {
    let buildingsResponse = await remoteFunctions.getBuildings();
    let buildings = {};

    // Make building boint to buildingCode -> building
    for (const buildingR of buildingsResponse) {
      buildings[buildingR.buildingCode] = buildingR;
      buildingR.usages = {};
    }

    // Get usages in date range.
    const responseJson = await remoteFunctions.getUsage(
      startDate,
      endDate,
      utilTypes
    );
    
    // Goes through every key in the date range
    for (const key of Object.keys(responseJson)) {
      if (key in utilTypes) {
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
          }
        }
      }
    }
    
    // Sets state.
    this.setState({ buildings: buildings });
    this.createDescriptions(buildings);
  };

  componentDidUpdate(prevProps, prevState) {
    // eslint-disable-next-line react/prop-types
    if (
      prevState.startDate.getTime() !== this.state.startDate.getTime() ||
      prevState.endDate.getTime() !== this.state.endDate.getTime() ||
      prevState.utilTypes !== this.state.utilTypes
    ) {
      this.state.map.current.entities.clear();
      this.updateMapUsage(
        this.state.startDate,
        this.state.endDate,
        this.state.utilTypes
      );
    }
  }

  // Adds utility usage to building description
  createDescriptions() {
    // Create a clone of our initial buildings state
    let buildingsCopy = _.cloneDeep(this.state.buildings);
    for (const bCode of Object.keys(this.state.buildings)) {
      let building = buildingsCopy[bCode];
      let usages = building.usages;
      building.usageDesc = "";
      
      // Determines description based off id.
      for (const usageKey of Object.keys(usages)) {
        let usage = usages[usageKey];
        switch (usageKey) {
          case "1":
            building.usageDesc += `Natural Gas: ${usage.usage} kBTU <br/>`;
            break;
          case "2":
            building.usageDesc += `Electric: ${usage.usage} kBTU <br/>`;
            break;
          case "3":
            building.usageDesc += `Steam: ${usage.usage} kBTU <br/>`;
            break;
          case "4":
            building.usageDesc += `Geothermal: ${usage.usage} kBTU <br/>`;
            break;
          case "5":
            building.usageDesc += `Solar: ${usage.usage}\n kBTU <br/>`;
            break;
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
            color: "blue",
          });
          infoBox = new window.Microsoft.Maps.Infobox(location, {
            title: building.buildingName,
            description: building.usageDesc,
            visible: false,
          });
        } else {
          pin = new window.Microsoft.Maps.Pushpin(location, { color: "gray" });
          infoBox = new window.Microsoft.Maps.Infobox(location, {
            title: building.buildingName,
            description: "no data",
            visible: false,
          });
        }
        pinArray.push(pin);
        infoBoxArray.push(infoBox);
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
    this.updateMapUsage(
      this.state.startDate,
      this.state.endDate,
      this.state.utilTypes
    );
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