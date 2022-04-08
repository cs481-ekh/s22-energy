import React, { Component } from 'react';
import "../Map.css";
import PropTypes from 'prop-types';
import SideDrawer from "./SideDrawer";
import SDPSticker from "./SDPSticker";
import remoteFunctions from '../remote';
import bingMapsAPI from '../modules/bingMapAPI';
//const _ = require("lodash");

class Map extends Component {
    constructor(props) {
        super(props);
        const prevMonth = new Date();
        prevMonth.setMonth(prevMonth.getMonth() - 1);
        this.state = {
            endDate: new Date(),
            startDate: prevMonth,
            utilTypes: [],
            buildingData: {},
            map: React.createRef()
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
        let newBuildingData = {};
        for (let i = 0; i < utilTypes.length; i++) {
            console.log("Finding Data");
            const responseJson = await remoteFunctions.getUsage(startDate, endDate, utilTypes[i]);
            let newUsageData = responseJson[utilTypes[i]];
            for (let j = 0; j < newUsageData.length; j++) {
                let code = newUsageData[j].buildingCode;
                let usageInfo = newUsageData[j].utilityUsage;
                if (!(code in newBuildingData)) {
                    let buildingInfo = newUsageData[j].building;
                    newBuildingData[code] = {};
                    newBuildingData[code].building = buildingInfo;
                    newBuildingData[code].usageData = {};
                    newBuildingData[code].usageData[utilTypes[i]] = usageInfo;
                } else {
                    newBuildingData[code].usageData[utilTypes[i]] += usageInfo;
                }
            }
            console.log(newBuildingData);
        }
        this.setState({ buildingData: newBuildingData });
        this.createPins();
    };

    componentDidUpdate(prevProps, prevState) {
        // eslint-disable-next-line react/prop-types
        if (prevState.startDate.getTime() !== this.state.startDate.getTime() || prevState.endDate.getTime() !== this.state.endDate.getTime() || prevState.utilTypes !== this.state.utilTypes) {
            this.state.map.current.entities.clear();
            this.updateMapUsage(this.state.startDate, this.state.endDate, this.state.utilTypes);
        }
    }

    // Adds buildings from buildingData to the map by creating a location, pin, infobox
    // and event handler for each building. Infobox displays each building's usage info
    createPins() {
        // Create empty array for building pins and info boxes
        let pinArray = [];
        let infoBoxArray = [];

        for (const [key, value] of Object.entries(this.state.buildingData)) {
            console.log(key);
            let location;
            if (value.building.xCoord != null && value.building.yCoord != null) {
                location = new window.Microsoft.Maps.Location(value.building.xCoord, value.building.yCoord);
            }
            let pin;
            let infoBox;
            let description = "";
            let total = 0;
            for (let i = 0; i < this.state.utilTypes.length; i++) {
                let usageValue = 0;
                if (value.usageData[this.state.utilTypes[i]]) {
                    usageValue = value.usageData[this.state.utilTypes[i]];
                    total += value.usageData[this.state.utilTypes[i]];
                }
                switch (this.state.utilTypes[i]) {
                    case 0:
                        description += "Electric: " + usageValue + " kbtu<br/>";
                        break;
                    case 1:
                        description += "Gas: " + usageValue + " kbtu<br/>";
                        break;
                    case 2:
                        description += "Solar: " + usageValue + " kbtu<br/>";
                        break;
                    case 3:
                        description += "Steam: " + usageValue + " kbtu<br/>";
                        break;
                }
            }
            description += "Total: " + total + " kbtu<br/>";
            if (location && (total > 0)) {
                pin = new window.Microsoft.Maps.Pushpin(location,
                    {
                        color: 'blue',
                    });
                infoBox = new window.Microsoft.Maps.Infobox(location,
                    {
                        title: value.building.buildingName,
                        description: description,
                        visible: false
                    }
                );
                pinArray.push(pin);
                infoBoxArray.push(infoBox);
            }
        }
        // Create event handler for each pin/infobox and add them to the map
        for (let i = 0; i < pinArray.length; i++) {
            window.Microsoft.Maps.Events.addHandler(pinArray[i], 'click', function () {
                infoBoxArray[i].setOptions({ visible: true });
            });
            infoBoxArray[i].setMap(this.state.map.current);
            this.state.map.current.entities.push(pinArray[i]);

        }
    }

    async componentDidMount() {
        const mapRef = document.getElementById(this.props.id);
        this.state.map.current = await bingMapsAPI.waitGenerateMap(window, document, process.env.REACT_APP_API_KEY, mapRef);
        this.updateMapUsage(this.state.startDate, this.state.endDate, this.state.utilTypes);
    }
    render() {
        return (
            <>
                <SideDrawer
                    startDate={this.state.startDate}
                    setStartDate={this.boundStart}
                    endDate={this.state.endDate}
                    setEndDate={this.boundEnd}
                    utilTypes={this.state.utilTypes}
                    setUtilTypes={this.boundUtil}
                />
                <div id={this.props.id} ref={this.state.map}><SDPSticker /></div>
            </>
        );
    }
}

Map.propTypes = {
    id: PropTypes.string,
};

export default Map;