let remoteFunctions = {
  async getBuildings() {
    let responseJson = {};
    try {
      const requestOptions = {
        method: "GET",
        mode: "cors",
      };
      const response = await fetch(
        "http://localhost:8000/building",
        requestOptions
      );
      responseJson = await response.json();
      return responseJson;
    } catch (err) {
      console.log(err);
    }
    return responseJson;
  },
  async getUsage(startDate, endDate) {
    startDate = startDate.toISOString().split('T')[0];
    endDate = endDate.toISOString().split('T')[0];
    
    let responseJson = {};
    try {
      const requestOptions = {
        method: "GET",
        mode: "cors",
      };
      const response = await fetch(`http://localhost:8000/usage?start=${startDate}&end=${endDate}&utilIID=1`,requestOptions);
      responseJson = await response.json();
    } catch (err) {
      console.log(err);
    }
    return responseJson;
  },
};

module.exports = remoteFunctions;
