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
        this.state.map.current.entities.clear();
    }

    // Provide a function for our functional components to modify state.
    modifyEndDate(value) {
        this.setState({ endDate: value });
        this.state.map.current.entities.clear();
    }

    // Create function to modify utility types
    modifyUtilTypes(value) {
        this.setState({ utilTypes: value });
        this.state.map.current.entities.clear();
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
        if (prevState.startDate !== this.state.startDate || prevState.endDate !== this.state.endDate || prevState.utilTypes !== this.state.utilTypes) {
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
                switch(utility) {
                    case 0:
                        buildingMatch.description += "\nElectric usage: ";
                        break;
                    case 1:
                        buildingMatch.description += "\nGas usage: ";
                        break;
                    case 2:
                        buildingMatch.description += "\nSolar usage: ";
                        break;
                    case 3:
                        buildingMatch.description += "\nSteam usage: ";
                        break;
                }
                buildingMatch.description += this.state.usageData[i].utilityUsage.toString();
            }
        }
        this.createPins(buildingsCopy);
    }

    // Adds buildings from buildingData to the map by creating a location, pin, infobox
    // and event handler for each building. Infobox displays each building's usage info
    createPins(buildings) {
        const infoBoxTemplate = '<div id="infoboxText" style="background-color:White; border-style:solid; ' +
            'border-width:medium; border-color:DarkOrange; min-height:100px; width: 240px;">' +
            '<b id="infoboxTitle" style="position: absolute; top: 10px; left: 10px; width: 220px;">{title}</b>' +
            '<a id="infoboxDescription" style="position: absolute; top: 30px; left: 10px; width: 220px;">{description}</a></div>';

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
                            htmlContent: infoBoxTemplate.replace('{title}', building.buildingName).replace('{description}', building.description),
                            showCloseButton: true,
                            visible: false
                        }
                    );
                } else {
                    pin = new window.Microsoft.Maps.Pushpin(location, { color: 'gray' });
                    infoBox = new window.Microsoft.Maps.Infobox(location,
                        {
                            htmlContent: infoBoxTemplate.replace('{title}', building.buildingName).replace('{description}', 'no data'),
                            showCloseButton: true,
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