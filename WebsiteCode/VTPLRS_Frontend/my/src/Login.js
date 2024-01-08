import React from 'react';
import './Form.css'
import axios from 'axios';
import { Link } from 'react-router-dom';

export default class Login extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            email: "",
            password: ""
        }

        this.login = this.login.bind(this);
        this.handleChange = this.handleChange.bind(this);
    }

    handleChange(e) {
        this.setState({
            [e.target.name]: e.target.value
        })
    }

    login(e) {
        e.preventDefault();

        const data = {
            email: this.state.email,
            password: this.state.password
        }

        axios.post("http://localhost:4000/user/loginUser", data)
            .then(res => {
                console.log(res);
                localStorage.setItem('ID', res.data._id);
                localStorage.setItem('email', res.data.email);
                alert('Login Successful');
                this.props.history.push('/Formsuccess');
            })
            .catch(err => {
                alert("Unable to login check you credentials");
                console.log(err);
            })

    }

    render() {
        return (
            <div className="form-content-right">
                <form className='form' >
                    <h2>Login</h2>
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
                    <div className='form-inputs'>
                        <label className='form-label'>Password</label>
                        <input
                            className='form-input'
                            type='password'
                            name='password'
                            placeholder='Enter your password'
                            onChange={(e) => this.handleChange(e)}
                            value={this.state.password}
                            required
                        />
                    </div>
                    <div className='row'>
                        <div>
                            <button className='form-input-btn col' type='submit' onClick={this.login}>
                                Login
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        )
    }
}