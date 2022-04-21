import * as React from 'react';
import "./App.css";
import NavBar from "./components/NavBar";
//import SideDrawer from "./components/SideDrawer";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Map from "./components/Map";
import ScrollToTop from "./components/ScrollToTop";
import CsvReader from "./components/CsvReader";
import Admin from "./components/Admin-Splash";
const ResponsiveAppBar = () => {
    return (
        <Router basename={process.env.PUBLIC_URL}>
            <div>
                
                <NavBar/>
            </div>
            <ScrollToTop/>
            <Routes>
                <Route exact path="/" element={<Map id="myMap"/>} />
                <Route exact path="/map" element={<Map id="myMap"/>} />
                <Route exact path="/CsvReader" element={<CsvReader/>} />
                <Route path="/admin" element={<Admin/>} />
            </Routes>
        </Router>
    );
};

export default ResponsiveAppBar;
