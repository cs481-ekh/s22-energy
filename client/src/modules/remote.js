
const serverPort = process.env.REACT_APP_SERVER_PORT || 5000;
const userName = process.env.REACT_APP_API_USER;
const password = process.env.REACT_APP_API_PASSWORD;
const credentials = `Basic ${Buffer.from(`${userName}:${password}`).toString('base64')}`;
const baseURL = `process.env.REACT_APP_API_URL:${serverPort}/energy/api`;

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
        `${baseURL}/building`,
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
  async getUsage(startDate, endDate, utility) {
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
      let requestURL = new URL("usage", `${baseURL}/`);
      requestURL.searchParams.append("start", startDate);
      requestURL.searchParams.append("end", endDate);
      
      if (utility) {
        for (const utilID of utility) {
          requestURL.searchParams.append("utilID", utilID);
        }
      }
      const response = await fetch(
        requestURL,
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
          `${baseURL}/login?email=${email}&password=${password}`,
          requestOptions
      );
      responseJson = await response.json();
    } catch (err) {
      console.log(err);
    }
    return responseJson;
  },
  async uploadFile(file, utility) {

    let formData = new FormData();

    formData.append("file", file);
    formData.append("utilID", utility);

    // let responseJson = {};
    try {
      const requestOptions = {
        method: "POST",
        mode: "cors",
        body: formData,
        headers: {
          Authorization: credentials
        },
      };
      const response = await fetch(
          `${baseURL}/uploadFile`,
          requestOptions
      );
      return response;
      //responseJson = await response.json();
    } catch (err) {
      console.log(err);
    }
    return 0;
  },
  async getUtlities(){
    const requestOptions = {
      method: "GET",
      mode: "cors",
      headers: {
        Authorization: credentials
      },
    };
    
    try{
      const response = await fetch(
        `${baseURL}/utilities`,
        requestOptions
      );
      return await response.json();
    }
    catch(err){
      console.log(err);
    }
    
    
  }
};
export default remoteFunctions;
