import React from 'react';
import './Form.css'
import { Link } from 'react-router-dom';

export default class Register extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      name: "",
      email: "",
      phnNo: "",
      age: "",
      password: ""
    }

    this.signup = this.signup.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(e) {
    this.setState({
      [e.target.name]: e.target.value
    })
  }

  signup(e) {
    e.preventDefault();
    fetch('http://localhost:4000/user/createUser', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        "name": this.state.name,
        "phoneNo": this.state.phnNo,
        "email": this.state.email,
        "age": this.state.age,
        "password": this.state.password,
      }),
    }).then(async response => {
      const data = await response.text();
      console.log('Success:', data);
      if (data === 'User created successfully') {
        alert('Registration Successful');
      }
      else {
        alert('Registration Unsuccessful. Try Again!!');
      }
    }).catch((error) => {
      console.error('Error:', error);
      alert('fail');
    });
  }

  render() {
    return (
      <div className="form-content-right">
        <form className='form' >
          <h2>Register</h2>
          <div className='form-inputs'>
            <label className='form-label'>Name</label>
            <input
              className='form-input'
              type='text'
              name='name'
              placeholder='Enter your name'
              onChange={(e) => this.handleChange(e)}
              value={this.state.name}
            />
          </div>
          <div className='form-inputs'>
            <label className='form-label'>Phone Number</label>
            <input
              className='form-input'
              type='number'
              name='phnNo'
              placeholder='Enter your phone number'
              onChange={(e) => this.handleChange(e)}
              value={this.state.phnNo}
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
            />
          </div>
          <div className='form-inputs'>
            <label className='form-label'>Age</label>
            <input
              className='form-input'
              type='number'
              name='age'
              placeholder='Enter your age'
              onChange={(e) => this.handleChange(e)}
              value={this.state.age}
            />
          </div>
          <div className='form-inputs'>
            <label className='form-label'>Password</label>
            <input
              className='form-input'
              type='password'
              name='password'
              placeholder='Enter your password'
              onChange={(e) => this.handleChange(e)}
              value={this.state.password}
            />
          </div>
          <div className='row'>
            <div>
              <button className='form-input-btn col' type='submit' onClick={this.signup}>
                SignUp
                            </button>
            </div>
            <div>
              <Link to="/Login">
                <button className='form-input-btn col' type='submit'>
                  Login
                            </button>
              </Link>
            </div>
          </div>
        </form>
      </div>
    )
  }
}