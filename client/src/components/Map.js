import React, { Component } from 'react';
import PropTypes from 'prop-types';
import SideDrawer from "./SideDrawer";

// Example array of building data for the function below it
var buildingData = [
    {
      lat: 43.603714,
      long: -116.204826,
      title: "Administration Building",
      description: "Uses some energy",
      size: '150'   // size of circle around building in feet
    },
    {
      lat: 43.6029000,
      long: -116.195803,
      title: "Albertsons Stadium",
      description: "Uses some energy",
      size: '300'
    },
    {
      lat: 43.614856,
      long: -116.203084,
      title: "CCP",
      description: "Uses some energy",
      size: '150'
    },
    {
        lat: 43.600704,
        long: -116.19925,
        title: "HEMG",
        description: "Uses some energy",
        size: '150'
    },
    {
        lat: 43.60458,
        long: -116.198939,
        title: "Chaffee Hall",
        description: "Uses some energy",
        size: '200'
    }
];

// Create boundary for map (N, W, S, E)
var bounds;
function getBounds() {
    bounds = new window.Microsoft.Maps.LocationRect.fromLocations(
        new window.Microsoft.Maps.Location(43.787795, -116.658338), 
        new window.Microsoft.Maps.Location(43.419856, -115.886613)
    );    
}

// Adds building from buildingData to the map by creating a location, pin, infobox 
// and event handler for each building.
/*
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
*/

// Currently just creates an example polygon for the Extra Mile Arena
/*
function createPolygons(map) {
    var extraMileArenaLocation = new window.Microsoft.Maps.Location(43.603564, -116.198948);
    var extraMileArena = new window.Microsoft.Maps.Polygon([
    new window.Microsoft.Maps.Location(43.603964, -116.199576),
    new window.Microsoft.Maps.Location(43.603964, -116.198326),
    new window.Microsoft.Maps.Location(43.603160, -116.198326),
    new window.Microsoft.Maps.Location(43.603160, -116.199576),], { fillColor: 'rgba(0, 0, 255, 0.3', strokeColor: 'orange', strokeThickness: 1 });
    var extraMileArenaInfo = new window.Microsoft.Maps.Infobox(extraMileArenaLocation, 
        { 
            title: 'Extra Mile Arena', 
            description: 'Uses some energy', 
            visible: false 
        }
    );
    window.Microsoft.Maps.Events.addHandler(extraMileArena, 'click', function() {
        extraMileArenaInfo.setOptions({ visible: true });
    });
    extraMileArenaInfo.setMap(map);
    map.entities.push(extraMileArena);
}
*/

// Create circular polygon around each building with specified size
function createCircles(map) {
    
    // Create empty array for circles around building and info boxes
    var infoBoxArray = [];
    var circleArray = [];

    for (let i = 0; i < buildingData.length; i++) {
        var building = buildingData[i];
        var location = new window.Microsoft.Maps.Location(building.lat, building.long);
        var infoBox = new window.Microsoft.Maps.Infobox(location,
            {
                title: building.title,
                description: building.description,
                visible: false
            }  
        );
        window.Microsoft.Maps.loadModule('Microsoft.Maps.SpatialMath', function() {
            // Calculate the locations for a regular polygon that has 36 locations which will rssult in an approximate circle.
            var locs = window.Microsoft.Maps.SpatialMath.getRegularPolygon(location, building.size, 36, window.Microsoft.Maps.SpatialMath.DistanceUnits.Feet);
            var circle = new window.Microsoft.Maps.Polygon(locs, { fillColor: 'rgba(0, 0, 255, 0.3)', strokeColor: 'orange', strokeThickness: 1 });
            circleArray.push(circle);
        });
        infoBoxArray.push(infoBox);
    }

    // Create event handler for each circle/infobox and add them to the map
    for (let i = 0; i < circleArray.length; i++) {
        window.Microsoft.Maps.Events.addHandler(circleArray[i], 'click', function() {
            infoBoxArray[i].setOptions({ visible: true });
        });
        infoBoxArray[i].setMap(map);
        map.entities.push(circleArray[i]);
    }
}

class Map extends Component {
    constructor(props) {
        super(props);
        this.onScriptLoad = this.onScriptLoad.bind(this);
    }

    onScriptLoad() {
        getBounds();
        const map = new window.Microsoft.Maps.Map(document.getElementById(this.props.id), 
            {
                maxBounds: bounds,
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
        createCircles(map);
        //createPins(map);
        //createPolygons(map);
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
                <div style={{ 
                    width: "100%",
                    height: "calc(100VH - 160px)"
                    }} 
                    id={this.props.id}>
                </div>
            </>
        );
    }
}

Map.propTypes = {
    id: PropTypes.string,
};

export default Map;