import React from 'react';
import validate from './validateInfo';
import useForm from './useForm';
import './Form.css';

 
const Forgot = (submitForm) => {
  const { handleChange, handleSubmit, values, errors } = useForm(
    submitForm,
    validate
  );

  return (
    <div className='form-content-right'>
      <form onSubmit={handleSubmit} className='form' noValidate>
      <h2>Recover Password</h2>
        <div className='form-inputs'>
          <label className='form-label'>Email</label>
          <input
            className='form-input'
            type='email'
            name='email'
            placeholder='Enter your email'
            value={values.email}
            onChange={handleChange}
          />
          {errors.email && <p>{errors.email}</p>}
        </div>
        
        
        <button className='form-input-btn' type='submit'>
          Login
        </button>
        
      </form>
    </div>
  );
};

export default Forgot;
