import React, { useState, useEffect } from 'react';
//import { Button } from '../Button/Button';
import { Link, useHistory } from 'react-router-dom';
import './Navbar.css';


const Navbar = (props) => {

  let history = useHistory();

  const [click, setClick] = useState(false);
  const [button, setButton] = useState(true);

  const handleClick = () => setClick(!click);
  const closeMobileMenu = () => setClick(false);

  const logout = () => {
    alert("logging out")
    localStorage.removeItem('email');
    localStorage.removeItem('ID');
    history.push("/");
  }

  const showButton = () => {
    if (window.innerWidth <= 960) {
      setButton(false);
    } else {
      setButton(true);
    }
  };

  useEffect(() => {
    showButton();
  }, []);

  window.addEventListener('resize', showButton);

  return (
    <>
      <nav className='navbar'>
        <div className='navbar-container'>
          <a href='/Formsuccess' className='navbar-logo' onClick={closeMobileMenu}>
            ANTITHEFT <i className='fab fa-typo3' />
            <i class='fab fa-typo3' />
          </a>
          <div className='menu-icon' onClick={handleClick}>
            <i className={click ? 'fas fa-times' : 'fas fa-bars'} />
          </div>
          <ul className={click ? 'nav-menu active' : 'nav-menu'}>
            <li className='nav-item'>

              <a href='/home' className='nav-links' onClick={closeMobileMenu}>
                Home
              </a>
            </li>
            <li className='nav-item'>
              <a
                href='/services'
                className='nav-links'
                onClick={closeMobileMenu}
              >
                Settings
              </a>
            </li>
            <li className='nav-item'>
              <a
                href='/products'
                className='nav-links'
                onClick={closeMobileMenu}
              >
                Report Theft
              </a>
            </li>

            <li className="nav-item">
              {/* <Link
                to='/'
                className='nav-links'
                onClick={closeMobileMenu}
              >
                Log Out
              </Link> */}
              <button className="nav-links button-class" onClick={logout}>Logout</button>
            </li>
          </ul>
        </div>
      </nav>
    </>
  );
}

export default Navbar;