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
            usageData: [],
            buildings: [],
            map: React.createRef()
        };
        this.boundStart = this.modifyStartDate.bind(this);
        this.boundEnd = this.modifyEndDate.bind(this);
    }

    // Create a function to modify start date state.
    modifyStartDate(value) {
        this.setState({ startDate: value });
        this.state.map.current.entities.clear();
    }

    // Provide a function for our functinal components to modify state.
    modifyEndDate(value) {
        this.setState({ endDate: value });
        this.state.map.current.entities.clear();
    }

    /**
     * Updates the map usage with new start/end date.
     * @param {*} startDate - New start date
     * @param {*} endDate - New end date.
     */
    updateMapUsage = async (startDate, endDate) => {
        const responseJson = await remoteFunctions.getUsage(startDate, endDate);
        let newUsageData = [];
        responseJson.forEach(building => newUsageData.push({
            buildingCode: building.buildingCode,
            utilityUsage: building.utilityUsage
        }));
        this.setState({ usageData: newUsageData });
        this.createDescriptions(newUsageData);
    };

    componentDidUpdate(prevProps, prevState) {
        // eslint-disable-next-line react/prop-types
        if (prevState.startDate !== this.state.startDate || prevState.endDate !== this.state.endDate) {
            this.updateMapUsage(this.state.startDate, this.state.endDate, this.state.map);
        }
    }

    // Adds utility usage to building description
    createDescriptions() {
        // Create a clone of our initial buildings state
        let buildingsCopy = _.cloneDeep(this.state.buildings);
        for (var i = 0; i < this.state.usageData.length; i++) {
            // Check if utility data exists for specific building code
            if (buildingsCopy.find(o => o.buildingCode === this.state.usageData[i].buildingCode)) {
                var buildingMatch = buildingsCopy.find(o => o.buildingCode === this.state.usageData[i].buildingCode);
                buildingMatch.description = "Gas usage: " + this.state.usageData[i].utilityUsage.toString();
            }
        }
        console.log(this.state.buildings);
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
        console.log(this.state.map.current);
        const buildings = await remoteFunctions.getBuildings();
        this.setState({ buildings: buildings });
    }
    render() {
        return (
            <>
                <SideDrawer
                    startDate={this.state.startDate}
                    setStartDate={this.boundStart}
                    endDate={this.state.endDate}
                    setEndDate={this.boundEnd}
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