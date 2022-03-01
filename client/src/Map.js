import React, { Component } from 'react';
import { render } from 'react-dom';

class Map extends Component {
    constructor(props) {
        super(props);
        this.onScriptLoad = this.onScriptLoad.bind(this);
    };

    onScriptLoad() {
        const map = new window.Microsoft.Maps.Map(document.getElementById(this.props.id), this.props.options);
        this.props.onMapLoad(map);
    };

    componentDidMount() {
        if (!window.Microsoft) {
            var s = document.createElement('script');
            s.type = 'text/javascript';
            s.src = 'https://www.bing.com/api/maps/mapcontrol?key=AkySSljBdLWqXdpNOTtafNtCNSrnBAyzXzM76G3vdrNKSLLrIPOjJDE4Q278vgmC';
            var x = document.getElementsByTagName('script')[0];
            x.parentNode.insertBefore(s, x);
            s.addEventListener('load', e => {
                this.onScriptLoad();
            })
        } else {
            this.onScriptLoad();
        }
    };

    render() {
        return (
            <div style={{ width: "75vw", height: "50vh", position: "center" }} id={this.props.id}></div>
        );
    };
}

export default Map;