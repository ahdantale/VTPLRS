import React from 'react';
	import { Link } from 'react-router-dom';
	

	function CardItem(props) {
	  return (
	    <>
	      <li className='cards__item'>
	        <Link className='cards__item__link' to={props.path}>
	          <figure className=''>
	            <img
	              className=''
	              alt='Bike Image'
	              src={props.src}
	            />
	          </figure>
	          
	        </Link>
	      </li>
	    </>
	  );
	}
	

	export default CardItem;

