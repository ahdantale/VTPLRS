
import React from 'react';
import './Cards.css';
import {
  Card, ListGroupItem, ListGroup
} from 'react-bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';
import { Button } from 'react-bootstrap';
import { Link } from 'react-router-dom';
import axios from 'axios'
import Navbar from './components/Navbar/Navbar';


export default class VDCard extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      vehicleNo: "",
      model: "",
      color: "",
      regNo: ""
    }
  }

  componentDidMount() {
    const email = localStorage.getItem('email');
    const id = localStorage.getItem('ID');
    if (email === " ") {
      this.setState({
        vehicleNo: "",
        model: "",
        color: "",
        regNo: ""
      })
    }

    axios.post('http://localhost:4000/vehicle/getVehicle', email)
      .then(res => {
        console.log(res.data)
        this.setState({
          vehicleNo: id,
          model: res.data.model,
          color: res.data.colour,
          regNo: res.data.registration
        })
      }).catch(err => {
        console.log(err);
      })
  }

  render() {
    return (
      <div>
        <div><Navbar />
        </div>
        <div className='cards'>
          <h1>Vehicle Details</h1>
          <div className='cards__container'>
            <div className='cards__wrapper'>
              <div className='cards__items'>
                <div className='cards__item'>
                  <Card>

                    <img src="https://images.financialexpress.com/2019/11/Hero-110cc-motorcycles660.jpg" className="rounded float-left" alt="aligment" />

                    <Card.Body>

                      <ListGroup className="list-group-flush">
                        <ListGroupItem>Vehicle No. : {this.state.vehicleNo}</ListGroupItem>
                        <ListGroupItem>Model : {this.state.model}</ListGroupItem>
                        <ListGroupItem>Color : {this.state.color}</ListGroupItem>
                        <ListGroupItem>Registration No. : {this.state.regNo}</ListGroupItem>
                      </ListGroup>
                    </Card.Body>
                  </Card>
                </div>

              </div>


            </div>

          </div>
          <div>

            <form>
              <div className='row set-alignment'>
                <div className='col'>
                  <Link to="/Addvehicle">
                    <Button variant="btn btn-success" >Add Vehicle
              </Button>
                  </Link>
                </div>
                <div className='col'>
                  <Link to="/LocationHistory">
                    <Button variant="btn btn-success" >Location History
              </Button>
                  </Link>
                </div>
                <div className='col'>
                  <Link to="/UserDetails">
                    <Button variant="btn btn-success" >User Details
              </Button>
                  </Link>
                </div>

              </div>
            </form>
          </div>
        </div>
      </div>
    );
  }
}

