import React, { Component } from 'react';
import "../Map.css";
import PropTypes from 'prop-types';
import SideDrawer from "./SideDrawer";
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
            utilTypes: [0, 1, 2, 3],
            usageData: [],
            buildings: [],
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
        let newUsageData = [];
        for (let i = 0; i < utilTypes.length; i++) {
            const responseJson = await remoteFunctions.getUsage(startDate, endDate, utilTypes[i]);
            responseJson.forEach(building => newUsageData.push({
                buildingCode: building.buildingCode,
                utilityUsage: building.utilityUsage
            }));
            this.setState({ usageData: newUsageData });
            this.createDescriptions(utilTypes[i]);
        }
    };

    componentDidUpdate(prevProps, prevState) {
        // eslint-disable-next-line react/prop-types
        if (prevState.startDate.getTime() !== this.state.startDate.getTime() || prevState.endDate.getTime() !== this.state.endDate.getTime() || prevState.utilTypes !== this.state.utilTypes) {
            this.state.map.current.entities.clear();
            this.updateMapUsage(this.state.startDate, this.state.endDate, this.state.utilTypes);
        }
    }

    // Adds utility usage to building description
    createDescriptions(utility) {
        // Create a clone of our initial buildings state
        let buildingsCopy = _.cloneDeep(this.state.buildings);
        for (var i = 0; i < this.state.usageData.length; i++) {
            // Check if utility data exists for specific building code
            if (buildingsCopy.find(o => o.buildingCode === this.state.usageData[i].buildingCode)) {
                var buildingMatch = buildingsCopy.find(o => o.buildingCode === this.state.usageData[i].buildingCode);
                if (utility === 0) {
                    buildingMatch.description += "\nElectric usage: ";
                } else if (utility === 1) {
                    buildingMatch.description += "\nGas usage: ";
                } else if (utility === 2) {
                    buildingMatch.description += "\nSolar usage: ";
                } else {
                    buildingMatch.description += "\nSteam usage: ";
                }
                buildingMatch.description += this.state.usageData[i].utilityUsage.toString();
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
        for (let i = 0; i < buildings.length; i++) {
            var building = buildings[i];
            let location;
            if (building.xCoord != null && building.yCoord != null) {
                location = new window.Microsoft.Maps.Location(building.xCoord, building.yCoord);
            }
            var pin;
            var infoBox;

            if (location) {
                // If there is utility data for the building add it to the info box and color the pin
                if ('description' in building) {
                    pin = new window.Microsoft.Maps.Pushpin(location,
                        {
                            color: 'blue',
                        });
                    infoBox = new window.Microsoft.Maps.Infobox(location,
                        {
                            title: building.buildingName,
                            description: building.description,
                            visible: false
                        }
                    );
                } else {
                    pin = new window.Microsoft.Maps.Pushpin(location, { color: 'gray' });
                    infoBox = new window.Microsoft.Maps.Infobox(location,
                        {
                            title: building.buildingName,
                            description: "no data",
                            visible: false
                        }
                    );
                }
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
        const buildings = await remoteFunctions.getBuildings();
        this.setState({ buildings: buildings });
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

                <div id={this.props.id} ref={this.state.map} />
            </>
        );
    }
}

Map.propTypes = {
    id: PropTypes.string,
};

export default Map;