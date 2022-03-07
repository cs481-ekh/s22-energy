import React, { Component } from 'react';
import PropTypes from 'prop-types';

// Create boundary for map (N, W, S, E)
var bounds = new window.Microsoft.Maps.LocationRect.fromLocations(
    new window.Microsoft.Maps.Location(43.787795, -116.658338), 
    new window.Microsoft.Maps.Location(43.419856, -115.886613)
);

// Create push pin and info box for different buildings
    // Administration Building
    var adminBuildingLocation = new window.Microsoft.Maps.Location(43.603714, -116.204826);
    var adminBuildingPin = new window.Microsoft.Maps.Pushpin(adminBuildingLocation, { color: 'blue' });
    var adminBuildingInfo = new window.Microsoft.Maps.Infobox(adminBuildingLocation, 
        { 
            title: 'Administration Building', 
            description: 'Uses some energy', 
            visible: false 
        }
    );
    window.Microsoft.Maps.Events.addHandler(adminBuildingPin, 'click', function() {
        adminBuildingInfo.setOptions({ visible: true });
    });
        
    // Ron and Linda Yanke Family Research Park (YFRP)
    var yfrpBuildingLocation = new window.Microsoft.Maps.Location(43.599887, -116.183733);
    var yfrpBuildingPin = new window.Microsoft.Maps.Pushpin(yfrpBuildingLocation, { color: 'blue' });
    var yfrpBuildingInfo = new window.Microsoft.Maps.Infobox(yfrpBuildingLocation, 
        { 
            title: 'Ron and Linda Yanke Family Research Park (YFRP)', 
            description: 'Uses some energy', 
            visible: false 
        }
    );
    window.Microsoft.Maps.Events.addHandler(yfrpBuildingPin, 'click', function() {
        yfrpBuildingInfo.setOptions({ visible: true });
    });

    // Clearwater Building at City Center Plaza (CCP)
    var ccpBuildingLocation = new window.Microsoft.Maps.Location(43.615197, -116.203549);
    var ccpBuildingPin = new window.Microsoft.Maps.Pushpin(ccpBuildingLocation, { color: 'blue' });
    var ccpBuildingInfo = new window.Microsoft.Maps.Infobox(ccpBuildingLocation, 
        { 
            title: 'Clearwater Building at City Center Plaza', 
            description: 'Uses some energy', 
            visible: false 
        }
    );
    window.Microsoft.Maps.Events.addHandler(ccpBuildingPin, 'click', function() {
        ccpBuildingInfo.setOptions({ visible: true });
    });

// Example array of building data for the function below it
/*
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
*/

  // Loop through building data and create a pin, info box and event handler for each
  // TODO: fix so that an individual event handler is created for each pushpin, currently each 
  //       pin pulls up the last building info in the array instead of their own
  /*
  for (let i = 0; i < buildingData.length; i++) {
    var building = buildingData[i];
    var location = new Microsoft.Maps.Location(building.lat, building.long);
    var pin = new Microsoft.Maps.Pushpin(location, null);
    var infoBox = new Microsoft.Maps.Infobox(location,
        { 
            title: building.title, 
            description: building.description, 
            visible: false 
        }
    );
    infoBox.setMap(map);
    Microsoft.Maps.Events.addHandler(pin, 'click', function() {
      infoBox.setOptions({ visible: true });
    });
    map.entities.push(pin);
  }
  */

  var extraMileArenaLocation = new window.Microsoft.Maps.Location(43.603564, -116.198948);

  var extraMileArena = new window.Microsoft.Maps.Polygon([
    new window.Microsoft.Maps.Location(43.603964, -116.199576),
    new window.Microsoft.Maps.Location(43.603964, -116.198326),
    new window.Microsoft.Maps.Location(43.603160, -116.198326),
    new window.Microsoft.Maps.Location(43.603160, -116.199576),], { fillColor: 'rgba(0, 0, 255, 0.5', strokeColor: 'orange', strokeThickness: 1 });

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
        // Add push pins, info boxes and polygons to map
        adminBuildingInfo.setMap(map);
        map.entities.push(adminBuildingPin);
        yfrpBuildingInfo.setMap(map);
        map.entities.push(yfrpBuildingPin);
        ccpBuildingInfo.setMap(map);
        map.entities.push(ccpBuildingPin);
        extraMileArenaInfo.setMap(map);
        map.entities.push(extraMileArena);
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