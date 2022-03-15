import * as React from 'react';
import "./App.css";
import NavBar from "./components/NavBar";
//import SideDrawer from "./components/SideDrawer";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Map from "./components/Map";
import Login from "./components/Login";
import ScrollToTop from "./components/ScrollToTop";
import Admin from "./components/Admin-Splash";

const ResponsiveAppBar = () => {
    return (
        <Router>
            <div>
                <NavBar/>
            </div>
            <ScrollToTop/>
            <Routes>
                <Route exact path="/" element={<Map id="myMap"/>} />
                <Route exact path="/map" element={<Map id="myMap"/>} />
                <Route path="/login" element={<Login/>} />
                <Route path="/admin" element={<Admin/>} />
            </Routes>
        </Router>
    );
};

export default ResponsiveAppBar;
