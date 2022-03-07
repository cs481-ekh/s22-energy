import React, { Component } from 'react';
import PropTypes from 'prop-types';

// Create boundary for map (N, W, S, E)
var bounds = new window.Microsoft.Maps.LocationRect.fromLocations(
    new window.Microsoft.Maps.Location(43.787795, -116.658338), 
    new window.Microsoft.Maps.Location(43.419856, -115.886613)
);

// Example array of building data for the function below it
var buildingData = [
    {
      lat: 43.603714,
      long: -116.204826,
      title: "Administration Building",
      description: "Uses some energy"
    },
    {
      lat: 43.603465,
      long: -116.195803,
      title: "Albertsons Stadium",
      description: "Uses some energy"
    },
    {
      lat: 43.614856,
      long: -116.203084,
      title: "CCP",
      description: "Uses some energy"
    }
];

// Adds building from buildingData to the map by creating a location, pin, infobox 
// and event handler for each building.
function createBuildings(map) {

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

// Currently just creates an example polygon for the Extra Mile Arena
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

class Map extends Component {
    constructor(props) {
        super(props);
        this.onScriptLoad = this.onScriptLoad.bind(this);
    }

    onScriptLoad() {
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
        createBuildings(map);
        createPolygons(map);
    }

    componentDidMount() {
        if (!window.Microsoft) {
            var s = document.createElement('script');
            s.type = 'text/javascript';
            s.src = 'https://www.bing.com/api/maps/mapcontrol?key=' + process.env.REACT_MAP_API_KEY;
            var x = document.getElementsByTagName('script')[0];
            x.parentNode.insertBefore(s, x);
            s.addEventListener('load', e => {
                if (e != null) {
                    this.onScriptLoad();
                }
            });
        } else {
            this.onScriptLoad();
        }
    }

    // need to move 240px right when sidebar is opened
    render() {
        return (
            <div style={{ 
                width: "calc(100VW - 120px)", 
                height: "calc(100VH - 224px)", 
                marginLeft: "60px", 
                marginBottom: "60px" 
                }} 
                id={this.props.id}>
            </div>
        );
    }
}

Map.propTypes = {
    id: PropTypes.string,
};

export default Map;