
import React, { useState, useEffect } from 'react';
import './Cards.css';
import {
  Card, ListGroupItem, ListGroup
} from 'react-bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';
import Navbar from './components/Navbar/Navbar';
import axios from 'axios'

function Cards() {

  const [fileUrl, setFileUrl] = useState("");

  const getFileFromServer = () => {
    axios('http://localhost:4000/payload/getComplaintFormat', {
      method: "GET",
      responseType: "blob"
    })
      .then(res => {
        const file = new Blob([res.data], {
          type: "application/pdf"
        });
        const fileURL = URL.createObjectURL(file);
        setFileUrl(fileURL)
      }).catch(err => {
        console.log('Error ', err);
      })
  }

  useEffect(() => {
    getFileFromServer();
  }, [])

  const getComplaint = () => {
    window.open(fileUrl);
  }

  return (
    <div>
      <div>
        <Navbar />
      </div>
      <div className='cards'>
        <h1>Report Theft</h1>
        <div className='cards__container'>
          <div className='cards__wrapper'>
            <div className='cards__items'>

              <div className='cards__item'>
                <Card style={{ width: '30rem' }}>
                  <ListGroup className="list-group-flush">
                    <ListGroupItem>
                      <a href={fileUrl} download>
                        <button className="fir-button">Fir format download</button>
                      </a>
                    </ListGroupItem>
                    <ListGroupItem><button className="fir-button" onClick={getComplaint}>Complain Type</button></ListGroupItem>
                    <ListGroupItem><Card.Link href="#">Phone No. : 0712-274-6555</Card.Link></ListGroupItem>
                  </ListGroup>
                </Card>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Cards;

