
import React from 'react';
import './Cards.css';
import {
  Card, ListGroupItem, ListGroup
} from 'react-bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';
import axios from 'axios';


class UserDetails extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      name: "",
      email: "",
      age: "",
      phnNo: ""
    }

  }

  componentDidMount() {
    const email = localStorage.getItem('email');
    axios.post("http://localhost:4000/user/getUser", email)
      .then(res => {
        console.log("User details : ", res.data)
        this.setState({
          name: res.data.name,
          email: res.data.email,
          age: res.data.age,
          phnNo: res.data.phoneNo
        })
      }).catch(err => {
        console.log(err)
      })
  }

  render() {
    return (
      <div className='cards'>
        <h1>User Profile</h1>
        <div className='cards__container'>
          <div className='cards__wrapper'>
            <div className='cards__items'>
              <div className='cards__item'>
                <Card>
                  <Card.Body>
                    <ListGroup className="list-group-flush">
                      <ListGroupItem>Owner Name : {this.state.name}</ListGroupItem>
                      <ListGroupItem>Registered Email : {this.state.email}</ListGroupItem>
                      <ListGroupItem>User Age : {this.state.age}</ListGroupItem>
                      <ListGroupItem>Phone.No : {this.state.phnNo}</ListGroupItem>
                    </ListGroup>
                  </Card.Body>
                </Card>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }

}
export default UserDetails;

