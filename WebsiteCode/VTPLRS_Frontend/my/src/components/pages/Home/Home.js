import React from 'react';
import '../../../App.css';
import HeroSection from './HeroSection';
import Navbar from '../../Navbar/Navbar';
import { Map, TileLayer, Marker, Popup } from 'react-leaflet'
import './HeroSection.css'
import '../../../../node_modules/leaflet/dist/leaflet.css'
import L from 'leaflet'
import leafRed from './marker.png'


class Home extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      lat: 21.11313,
      long: 79.07037,
    }
  }

  redIcon = L.icon({
    iconUrl: leafRed,
    iconSize: [50, 90], // size of the icon
    shadowSize: [50, 64], // size of the shadow
    iconAnchor: [22, 94], // point of the icon which will correspond to marker's location
    shadowAnchor: [4, 62],  // the same for the shadow
    popupAnchor: [-3, -86]
  });

  render() {
    return (
      <>
        <div>
          <Navbar />
        </div>
        <div className="container">
          <Map className="map-container" center={[this.state.lat, this.state.long]} zoom={8} scrollWheelZoom={true}>
            <TileLayer
              attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
              url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
            />
            <Marker position={[this.state.lat, this.state.long]} icon={this.redIcon}>
              <Popup>
                Latitude: {this.state.lat}<br />
               Longitude: {this.state.long}
              </Popup>
            </Marker>
          </Map>
        </div>
        <center><div className="caption"><b>Current Location of User</b></div></center>
      </>
    );
  }
}

export default Home;
