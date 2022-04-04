const serverPort = process.env.REACT_APP_SERVER_PORT || 5000;
let remoteFunctions = {
  async getBuildings() {
    let responseJson = {};
    try {
      const requestOptions = {
        method: "GET",
        mode: "cors",
      };
      const response = await fetch(
        `http://localhost:${serverPort}/building`,
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
      const response = await fetch(`http://localhost:${serverPort}/usage?start=${startDate}&end=${endDate}&utilID=1`,requestOptions);
      responseJson = await response.json();
    } catch (err) {
      console.log(err);
    }
    return responseJson;
  },
  async getUser(email, password) {

    let responseJson = {};
    try {
      const requestOptions = {
        method: "GET",
        mode: "cors",

      };
      const response = await fetch(`http://localhost:${serverPort}/login?email=${email}&password=${password}`,requestOptions);
      responseJson = await response.json();
    } catch (err) {
      console.log(err);
    }
    return responseJson;
  },
};
export default remoteFunctions;
