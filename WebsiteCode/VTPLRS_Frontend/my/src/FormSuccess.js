import React from 'react';
import Navbar from './components/Navbar/Navbar';
import Home from './components/pages/Home/Home';
import VDCard from './VehihcleDetails';
import Cards from './ReportTheft';
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';
import LHCards from './LocationHistory';
import Addvehicle from './Addvehicle';
import UserDetails from './UserDetails';

class FormSuccess extends React.Component {

  render() {
    return (
      <>
        <Router>
          <Navbar />
          <div>
          </div>
          {/* <Switch>
            <Route exact path='/home' exact component={Home} />
            <Route path='/services' exact component={VDCard} />
            <Route path='/products' exact component={Cards} />
            <Route path='/LocationHistory' exact component={LHCards} />
            <Route path='/Addvehicle' exact component={Addvehicle} />
            <Route path='/UserDetails' exact component={UserDetails} />
          </Switch> */}
        </Router>
      </>

    );
  };
}

export default FormSuccess;
