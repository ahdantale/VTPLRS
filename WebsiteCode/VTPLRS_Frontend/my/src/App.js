import React from 'react';
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';
import Forgot from './Forgot';
import Form from './Form';
import './Form.css';
import './App.css';
import Login from './Login';
import FormSignup from './FormSignup';
import FormSuccess from './FormSuccess';
import LHCards from './LocationHistory';
import Addvehicle from './Addvehicle';
import UserDetails from './UserDetails';
import Home from './components/pages/Home/Home';
import VDCard from './VehihcleDetails';
import Cards from './ReportTheft';

function App() {
  return (
    <div className='form-container'>
      <Router>
        <Switch>
          <Route exact path='/' component={FormSignup} />
          <Route path='/Form' component={Form} />
          <Route path='/Login' component={Login} />
          <Route path='/Forgot' component={Forgot} />
          <Route path='/Formsuccess' component={FormSuccess} />
          <Route exact path='/home' exact component={Home} />
          <Route path='/services' exact component={VDCard} />
          <Route path='/products' exact component={Cards} />
          <Route path='/LocationHistory' exact component={LHCards} />
          <Route path='/Addvehicle' exact component={Addvehicle} />
          <Route path='/UserDetails' exact component={UserDetails} />
        </Switch>
      </Router>

    </div>
  )
}

export default App;
