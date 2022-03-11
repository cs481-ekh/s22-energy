import * as React from 'react';
import "./App.css";
import NavBar from "./NavBar";
import SideDrawer from "./SideDrawer";
import Map from "./Map";

const ResponsiveAppBar = () => {
    return (
        <div>
            <NavBar/>
            <SideDrawer/>
            <Map id="myMap"/>            
        </div>
    );
};

export default ResponsiveAppBar;
