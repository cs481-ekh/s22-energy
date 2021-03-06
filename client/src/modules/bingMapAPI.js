import '../customInfoBox.css';

 let infoboxArray = [];
 window.closeInfobox = function(test){
   const item = infoboxArray[test];
   item.setOptions({visible: false});
 };
  
 
let bingMapsAPI = {
  /**
   * Injects the bing api javascript into our application
   * @param {*} document 
   * @param {*} key 
   */
  injectScript(document, url, key) {
    if (key) {
      url += `&key=${key}`;
    }
    const script = document.createElement("script");
    script.type = "text/javascript";
    script.async = true;
    script.defer = true;
    script.src = url;
    document.body.appendChild(script);
  },

  // Create boundary for map (N, W, S, E)
  getBounds() {
    var bounds = new window.Microsoft.Maps.LocationRect.fromLocations(
      new window.Microsoft.Maps.Location(43.787795, -116.658338),
      new window.Microsoft.Maps.Location(43.419856, -115.886613)
    );
    return bounds;
  },

  /**
   * Creates a new promise with specified timeout
   * @param {*} ms - Amount of time for timeout
   * @returns promise
   */
  timeout(ms) {
    return new Promise((resolve) => setTimeout(resolve, ms));
  },

  /**
   * Makes async function sleep for specified number of ms
   * @param {*} ms - Amount of time for async function to sleep
   */
  async sleep(ms) {
    await bingMapsAPI.timeout(ms);
  },

  /**
   * Waits for the map to load
   * @param {*} window - DOM window
   * @param {*} document - Document (root of html page)
   * @param {*} key - API key for react
   * @param {*} mapRef - Reference to the DOM id to inject script into.
   * @returns - Bing map object.
   */
  async waitGenerateMap(window, document, key, mapRef) {
    let map;
    bingMapsAPI.injectScript(document, "https://www.bing.com/api/maps/mapcontrol", key);
    // Wait for window to load
    while (!window.Microsoft && !window.Microsoft.Maps);

    // Add a timeout since bings maps does async functions
    await bingMapsAPI.sleep(500);

    // Generate map after script fully loaded
    map = bingMapsAPI.generateMap(mapRef);
    return map;
  },

clearInfoBoxes(){
  for(const infoBox of infoboxArray){
    infoBox.setOptions({visible: false});
  }
  infoboxArray = [];
},

generateCustomInfoBox(dataArray){
  // Clear any old info boxes
  bingMapsAPI.clearInfoBoxes();
  
  for(let i = 0; i < dataArray.length; i++){
    let infoBoxData = dataArray[i];
    var infoboxTemplate = "<div class='customInfobox'> " +
                            `<div class='headerRow'><span class = "title">{title}</span> <span onClick="closeInfobox(this.id)" id = "${i}" class="closeButton mdi mdi-close-circle"></span></div>` +
                            "<div class = 'description'>{description}" +
                              "</div>";

    //Some HTML to add a close button to the infobox.
    var closeButton = ``;

    //Pass the title and description into the template and pass it into the infobox as an option.
    let infobox = new window.Microsoft.Maps.Infobox(infoBoxData.location, {
        htmlContent: infoboxTemplate.replace('{title}', infoBoxData.title).replace('{description}', infoBoxData.description) + closeButton,
        visible: infoBoxData.visible
    });
    infoboxArray.push(infobox);
  }
  return infoboxArray;
},

  /**
   * Generates our map with the specified settings
   * @param {*} mapRef - Reference to the dom id to inject map into.
   * @returns - Bing map object.
   */
  generateMap(mapRef) {
    let map = new window.Microsoft.Maps.Map(mapRef, {
      maxBounds: this.getBounds(),
      center: new window.Microsoft.Maps.Location(43.605922, -116.202093),
      customMapStyle: {
        elements: {
          structure: { fillColor: "#FFFFFF" }, // Building colors
        },
      },
      disableKeyboardInput: true,
      disableStreetside: true,
      enableClickableLogo: false,
      mapTypeId: window.Microsoft.Maps.MapTypeId.road, // road, aerial, streetside
      showDashboard: false,
      showScalebar: false,
      showTermsLink: false,
      zoom: 15,
    });
    return map;
  },
};

export default bingMapsAPI;
