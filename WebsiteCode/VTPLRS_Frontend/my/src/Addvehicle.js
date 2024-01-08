import React from 'react';
import './Form.css';

class Addvehicle extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      make: "",
      model: "",
      colour: "",
      registration: "",
      email: "",
    }
    this.addDetails = this.addDetails.bind(this);
    this.handleChange = this.handleChange.bind(this);

  }
  handleChange(e) {

    const name = e.target.name;
    const value = e.target.value;
    this.setState({ [name]: value })
  }

  addDetails(event) {
    event.preventDefault();
    fetch('http://localhost:4000/vehicle/addVehicle', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        "make": this.state.make,
        "model": this.state.model,
        "colour": this.state.colour,
        "registration": this.state.registration,
        "email": this.state.email,
      }),
    })

      .then(async response => {
        const data = await response.text();
        console.log('Success:', data);
        if (data === 'Vehicle added successfully') {
          alert('Details added Successfully');
        }
        else {
          alert('Unsuccessful !!');
        }
      })
      .catch((error) => {
        console.error('Error:', error);
        alert('fail');
      });


  };


  render() {


    return (
      <div className='form-container'>

        <div className='form-content-right'>
          <form className='form' >
            <h2>Add Details</h2>
            <div className='form-inputs'>
              <label className='form-label'>Make</label>
              <input
                className='form-input'
                type='text'
                name='make'
                placeholder='Enter your make'
                onChange={(e) => this.handleChange(e)}
                value={this.state.make}
                required
              />

            </div>

            <div className='form-inputs'>
              <label className='form-label'>Model</label>
              <input
                className='form-input'
                type='text'
                name='model'
                placeholder='Enter your Model'
                onChange={(e) => this.handleChange(e)}
                value={this.state.model}
                required
              />

            </div>
            <div className='form-inputs'>
              <label className='form-label'>Color</label>
              <input
                className='form-input'
                type='text'
                name='colour'
                placeholder='Enter your color'
                onChange={(e) => this.handleChange(e)}
                value={this.state.colour}
                required

              />

            </div>
            <div className='form-inputs'>
              <label className='form-label'>Registration.No</label>
              <input
                className='form-input'
                type='text'
                name='registration'
                placeholder='Enter your Reg.No'
                onChange={(e) => this.handleChange(e)}
                value={this.state.regno}
                required
              />

            </div>

            <div className='form-inputs'>
              <label className='form-label'>Email</label>
              <input
                className='form-input'
                type='text'
                name='email'
                placeholder='Enter your email'
                onChange={(e) => this.handleChange(e)}
                value={this.state.email}
                required
              />

            </div>
            <div className='row'>
              <div>
                <button className='form-input-btn col' type='submit' onClick={this.addDetails}>
                  Submit Details
        </button>
              </div>
            </div>
          </form>
        </div>
      </div>
    );
  };
}

export default Addvehicle;
