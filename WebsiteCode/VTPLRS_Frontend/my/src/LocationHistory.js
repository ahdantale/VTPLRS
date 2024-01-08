import React from 'react';
import './Cards.css';
import HeroSection from './components/pages/Home/HeroSection';

import {
  Card, ListGroupItem, ListGroup
} from 'react-bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';
import '../node_modules/leaflet/dist/leaflet.css'
import L from 'leaflet'
import leafRed from './components/pages/Home/marker.png'
import { Map, TileLayer, Marker, Popup } from 'react-leaflet'
import data from './data';



class LHCards extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      lat: 21.11313,
      long: 79.07037,
      locations: [[21.157393, 79.008615], [21.165507, 79.050773], [21.207092, 78.981990], [20.202864, 78.143039]]
    }
  }

  componentDidMount() {
    navigator.geolocation.getCurrentPosition(function (position) {
      console.log("Latitude is :", position.coords.latitude);
      console.log("Longitude is :", position.coords.longitude);
    });
  }

  redIcon = L.icon({
    iconUrl: leafRed,
    iconSize: [30, 60], // size of the icon
    shadowSize: [50, 64], // size of the shadow
    iconAnchor: [22, 94], // point of the icon which will correspond to marker's location
    shadowAnchor: [4, 62],  // the same for the shadow
    popupAnchor: [-3, -86]
  });

  render() {
    return (
      <div className='cards'>
        <h1>Location History</h1>
        <div className=''>
          <div className='cards__wrapper'>
            <div className='cards__items'>
              <div className='col-6'>
                <div className='row'>
                  <div className='cards__item '>
                    <Card >
                      <Card.Body>
                        <Card.Title>Current Loction Details</Card.Title>
                      </Card.Body>
                      <ListGroup className="list-group-flush">
                        <ListGroupItem>Vehicle No. : <b>{data[0].vno}</b></ListGroupItem>
                        <ListGroupItem>Area : <b>{data[0].area}</b></ListGroupItem>
                        <ListGroupItem>Time : <b>{data[0].time}</b></ListGroupItem>
                        <ListGroupItem>Date : <b>{data[0].date}</b></ListGroupItem>
                      </ListGroup>
                    </Card>
                  </div>
                  <div className='cards__item '>
                    <Card >
                    <Card.Body>
                        <Card.Title>Previous Loction Details</Card.Title>
                      </Card.Body>
                      <ListGroup className="list-group-flush">
                        <ListGroupItem>Vehicle No. : <b>{data[1].vno}</b></ListGroupItem>
                        <ListGroupItem>Area : <b>{data[1].area}</b></ListGroupItem>
                        <ListGroupItem>Time : <b>{data[1].time}</b></ListGroupItem>
                        <ListGroupItem>Date : <b>{data[1].date}</b></ListGroupItem>
                      </ListGroup>
                    </Card>
                  </div>
                </div>
                <div className='row'>
                  <div className='cards__item'>
                    <Card >
                      <Card.Body>
                        <Card.Title>Previous Loction Details</Card.Title>
                      </Card.Body>
                      <ListGroup className="list-group-flush">
                        <ListGroupItem>Vehicle No. : <b>{data[2].vno}</b></ListGroupItem>
                        <ListGroupItem>Area : <b>{data[2].area}</b></ListGroupItem>
                        <ListGroupItem>Time : <b>{data[2].time}</b></ListGroupItem>
                        <ListGroupItem>Date : <b>{data[2].date}</b></ListGroupItem>
                      </ListGroup>
                    </Card>
                  </div>
                  <div className='cards__item'>
                    <Card >
                      <Card.Body>
                        <Card.Title>Previous Loction Details</Card.Title>
                      </Card.Body>
                      <ListGroup className="list-group-flush">
                        <ListGroupItem>Vehicle No. : <b>{data[0].vno}</b></ListGroupItem>
                        <ListGroupItem>Area : <b>{data[3].area}</b></ListGroupItem>
                        <ListGroupItem>Time : <b>{data[3].time}</b></ListGroupItem>
                        <ListGroupItem>Date : <b>{data[3].date}</b></ListGroupItem>
                      </ListGroup>
                    </Card>
                  </div>
                </div>
              </div>
              <div className='col-6'>
                <div className="container">
                  {/* <HeroSection /> */}
                  <div>
                    <Map className="map" center={[this.state.lat, this.state.long]} zoom={12} scrollWheelZoom={true}>
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
                      <Marker position={[this.state.locations[0][0], this.state.locations[0][1]]} icon={this.redIcon}>
                        <Popup>
                          Latitude: {this.state.locations[0][0]}<br />
                          Longitude: {this.state.locations[0][1]}
                        </Popup>
                      </Marker>
                      <Marker position={[this.state.locations[1][0], this.state.locations[1][1]]} icon={this.redIcon}>
                        <Popup>
                          Latitude: {this.state.locations[1][0]}<br />
                          Longitude: {this.state.locations[1][1]}
                        </Popup>
                      </Marker>
                      <Marker position={[this.state.locations[2][0], this.state.locations[2][1]]} icon={this.redIcon}>
                        <Popup>
                          Latitude: {this.state.locations[2][0]}<br />
                          Longitude: {this.state.locations[2][1]}
                        </Popup>
                      </Marker>
                      <Marker position={[this.state.locations[3][0], this.state.locations[3][1]]} icon={this.redIcon}>
                        <Popup>
                          Latitude: {this.state.locations[3][0]}<br />
                          Longitude: {this.state.locations[3][1]}
                        </Popup>
                      </Marker>
                    </Map>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}


export default LHCards;

