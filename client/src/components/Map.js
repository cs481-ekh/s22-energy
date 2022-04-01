import React, { Component } from 'react';
import "../Map.css";
import PropTypes from 'prop-types';
import SideDrawer from "./SideDrawer";

// Holds building usage data (currently natural gas from 10/31/00 - 03/17/22)
// Not using the map data structure because of naming conflicts with this component lol
const usageData = [];

// Holds building data
const buildingData = [];

// GET request that populates building data array
const getBuildings = async () => {
    const requestOptions = {
        method: 'GET',
        mode: 'cors',
    };
    const response = await fetch("http://localhost:5000/building", requestOptions);
    const responseJson = await response.json();
    if (buildingData.length == 0) {
        responseJson.forEach(building => buildingData.push({
            buildingCode: building.buildingCode,
            buildingName: building.buildingName,
            lat: building.xCoord,
            long: building.yCoord
            // abbreviation, address, squareFt, yearBuilt
        }));
    }
};

// GET request that populates usage data array
const getUsage = async (map) => {
    const requestOptions = {
        method: 'GET',
        mode: 'cors',
    };
    const response = await fetch("http://localhost:5000/usage?start=2000-10-31&end=2022-03-17&utilIID=1", requestOptions);
    const responseJson = await response.json();
    if (usageData.length == 0) {
        responseJson.forEach(building => usageData.push({
            buildingCode: building.buildingCode,
            utilityUsage: building.utilityUsage
            // id, utilityID, timestamp, cost
        }));
    }
    createDescriptions(map);
};

// Adds utility usage to building description
function createDescriptions(map) {
    for (var i = 0; i < usageData.length; i++) {
        // Check if utility data exists for specific building code
        if (buildingData.find(o => o.buildingCode === usageData[i].buildingCode)) {
            var buildingMatch = buildingData.find(o => o.buildingCode === usageData[i].buildingCode);
            buildingMatch.description = "Gas usage: " + usageData[i].utilityUsage.toString();
        }
    }
    createPins(map);
}

// Adds buildings from buildingData to the map by creating a location, pin, infobox
// and event handler for each building. Infobox displays each building's usage info
function createPins(map) {
    // Create empty array for building pins and info boxes
    var pinArray = [];
    var infoBoxArray = [];

    for (let i = 0; i < buildingData.length; i++) {
        var building = buildingData[i];
        if (building.lat != null && building.long != null) {
            var location = new window.Microsoft.Maps.Location(building.lat, building.long);
        }
        var pin;
        var infoBox;
        // If there is utility data for the building add it to the info box and color the pin
        if ('description' in building) {
            pin = new window.Microsoft.Maps.Pushpin(location, { color: 'blue' });
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

    // Create event handler for each pin/infobox and add them to the map
    for (let i = 0; i < pinArray.length; i++) {
        window.Microsoft.Maps.Events.addHandler(pinArray[i], 'click', function() {
            infoBoxArray[i].setOptions({ visible: true });
        });
        infoBoxArray[i].setMap(map);
        map.entities.push(pinArray[i]);
    }
}

// Create boundary for map (N, W, S, E)
function getBounds() {
    var bounds = new window.Microsoft.Maps.LocationRect.fromLocations(
        new window.Microsoft.Maps.Location(43.787795, -116.658338),
        new window.Microsoft.Maps.Location(43.419856, -115.886613)
    );
    return bounds;
}

class Map extends Component {
    constructor(props) {
        super(props);
        this.onScriptLoad = this.onScriptLoad.bind(this);
        const prevMonth = new Date();
        prevMonth.setMonth(prevMonth.getMonth()-1);
        this.state = {
            endDate: new Date(),
            startDate: prevMonth
        };
        this.setSDate = this.setStartDate.bind(this);
        this.setEDate = this.setEndDate.bind(this);
    }

    setStartDate(startDate){
        this.setState({startDate});
    }
    setEndDate(endDate) {
        this.setState({endDate});
    }
    
    onScriptLoad() {
        const map = new window.Microsoft.Maps.Map(document.getElementById(this.props.id),
            {
                maxBounds: getBounds(),
                center: new window.Microsoft.Maps.Location(43.605922, -116.202093),
                customMapStyle: {
                    elements: {
                        structure: { fillColor: '#FFFFFF'}  // Building colors
                    }
                },
                disableKeyboardInput: true,
                disableStreetside: true,
                enableClickableLogo: false,
                mapTypeId: window.Microsoft.Maps.MapTypeId.road, // road, aerial, streetside
                showDashboard: false,
                showScalebar: false,
                showTermsLink: false,
                zoom: 15
            }
        );
        getBuildings();
        getUsage(map);  // pass map for create pins function
    }

    componentDidMount() {
        if (!window.Microsoft.Maps.Location) {
            var s = document.createElement('script');
            s.type = 'text/javascript';
            s.src = 'https://www.bing.com/api/maps/mapcontrol?key=' + process.env.REACT_APP_API_KEY;
            var x = document.getElementsByTagName('script')[0];
            x.parentNode.insertBefore(s, x);
            s.addEventListener('load', e => {
                if (e != null) {
                    setTimeout(() => {  this.onScriptLoad(); }, 200);
                }
            });
        } else {
            this.onScriptLoad();
        }
    }

    render() {
        return (
            <>
                <SideDrawer 
                startDate={this.state.startDate} 
                setStartDate={this.setSDate}
                endDate={this.state.endDate}
                setEndDate={this.setEDate}
                />
                
                <div id={this.props.id}/>
            </>
        );
    }
}

Map.propTypes = {
    id: PropTypes.string,
};

export default Map;