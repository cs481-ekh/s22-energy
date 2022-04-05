const serverPort = process.env.REACT_APP_SERVER_PORT || 5000;
const userName = process.env.REACT_APP_API_USER;
const password = process.env.REACT_APP_API_PASSWORD;
const credentials = `Basic ${Buffer.from(`${userName}:${password}`).toString('base64')}`;

import  { Buffer } from 'buffer';
let remoteFunctions = {
  /**
   * Retrieves list of buildings from server.
   * @returns list of buildings
   */
  async getBuildings() {
    let responseJson = {};
    try {
      const requestOptions = {
        method: "GET",
        mode: "cors",
        headers: {
          Authorization: credentials
        },
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

  /**
   * Returns usage from the database
   * @param {*} startDate - Start date to retrieve usage
   * @param {*} endDate - End date to retrieve usage
   * @returns - List of usages
   */
  async getUsage(startDate, endDate) {
    startDate = startDate.toISOString().split("T")[0];
    endDate = endDate.toISOString().split("T")[0];

    let responseJson = {};
    try {
      const requestOptions = {
        method: "GET",
        mode: "cors",
        headers: {
          Authorization: credentials
        },
      };
      const response = await fetch(
        `http://localhost:${serverPort}/usage?start=${startDate}&end=${endDate}&utilIID=1`,
        requestOptions
      );
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
        // mode: "cors",
        headers: {
          Authorization: credentials
        },
      };
      const response = await fetch(
          `http://localhost:${serverPort}/login?email=${email}&password=${password}`,
          requestOptions
      );
      responseJson = await response.json();
    } catch (err) {
      console.log(err);
    }
    return responseJson;
  },
};
export default remoteFunctions;
