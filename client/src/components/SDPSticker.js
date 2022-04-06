import React from 'react';
import "../SDPSticker.css";
import SDPImage from "../imgs/sdp-logo-infinity.png";

function SDPSticker () {

    let displayInfo = false;

    function toggleInfo() {
        displayInfo = !displayInfo;
        if (displayInfo) {
            document.getElementById("sdp_info").style.visibility = "visible";
        } else {
            document.getElementById("sdp_info").style.visibility = "hidden";
        }
    }

    return (
            <div id="sdp">
                <img src={SDPImage} alt="senior design project logo" onClick={toggleInfo}/>
                <div id="sdp_info">
                    This website was created for a<br/>
                    Boise State University<br/>
                    Computer Science Senior Design Project by
                    <div> Jack Carr </div>
                    <div> Victor Cerda </div>
                    <div> Keegan Hanes </div>
                    <div> Aidan Leuck </div>
                    <div> Khaled Natouf </div>
                    <div> Taylor Poulsen </div>
                    For information about sponsoring a project go to<br/>
                    <a href="https://www.boisestate.edu/coen-cs/community/cs481-senior-design-project/">https://www.boisestate.edu/coen-cs/community/cs481-senior-design-project/</a>
                </div>
            </div>
    );
}

export default SDPSticker;