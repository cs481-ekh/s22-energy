import React, { Component } from 'react';
import "../Map.css";
import PropTypes from 'prop-types';
import SideDrawer from "./SideDrawer";

// Holds building usage data (currently natural gas from 10/31/00 - 03/17/22)
// Not using the map data structure because of naming conflicts with this component lol
const usageData = [];

// Holds building data
//const buildingData = [];

// Temp building data until building data endpoint is implemented
var buildingData = [
    {
        lat: 43.603714,
        long: -116.204826,
        title: "Administration Building",
        description: "Uses some energy",
        building: '004',
        size: '150'   // size of circle around building in feet
    },
    {
        lat: 43.6029000,
        long: -116.195803,
        title: "Albertsons Stadium",
        description: "Uses some energy",
        size: '035'
    },
    {
        lat: 43.614856,
        long: -116.203084,
        title: "CCP",
        description: "Uses some energy",
        size: '367'
    },
    {
        lat: 43.600704,
        long: -116.19925,
        title: "HEMG",
        description: "Uses some energy",
        size: '005'
    },
    {
        lat: 43.60458,
        long: -116.198939,
        title: "Chaffee Hall",
        description: "Uses some energy",
        size: '031'
    }
];


// GET request that populates usage data array
const getUsage = async () => {
    const requestOptions = {
        method: 'GET',
        mode: 'cors',
    };
    const response = await fetch("http://localhost:5000/usage?start=2000-10-31&end=2022-03-17&utilIID=1", requestOptions);
    const responseJson = await response.json();
    if (usageData.length == 0) {
        responseJson.forEach(building => usageData.push({
            building: building.buildingCode,
            utilityUseage: building.utilityUsage
            // id, utilityID, timestamp, cost
        }));
    }
};

// Adds buildings from buildingData to the map by creating a location, pin, infobox
// and event handler for each building. Infobox displays each building's usage info
function createPins(map) {

    // Create empty array for building pins and info boxes
    var pinArray = [];
    var infoBoxArray = [];

    // Create new location, pin and infobox
    for (let i = 0; i < buildingData.length; i++) {
        var building = buildingData[i];
        var location = new window.Microsoft.Maps.Location(building.lat, building.long);
        var pin = new window.Microsoft.Maps.Pushpin(location, { color: 'blue' });
        var infoBox = new window.Microsoft.Maps.Infobox(location,
            { 
                title: building.title, 
                description: building.description, 
                visible: false 
            }
        );
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
    }

    onScriptLoad() {
        getUsage();
        console.log(usageData);
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
        createPins(map);
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
                <SideDrawer/>
                <div id={this.props.id}/>
            </>
        );
    }
}

Map.propTypes = {
    id: PropTypes.string,
};

export default Map;