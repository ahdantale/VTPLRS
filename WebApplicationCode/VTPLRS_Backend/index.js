const express = require('express')
const cors = require('cors')

const mongoDBURL = "mongodb://localhost:27017/FYProject"
const app = express()
const mongoose = require('mongoose')
const bodyParser = require('body-parser')

mongoose.connect(mongoDBURL,{autoIndex:true})
    .then(()=>{
    console.log('Connected to database successfully')
    })
.catch(err=>console.error('Connection failed'))


//Testing for cleanup
const userOperations = require('./User/UserOperations.js')
const locationOperations = require('./Location/locationOperations.js')
const deviceOperations = require('./Device/deviceOperations.js')
const imageOperations = require('./Images/imageOperations.js')
const vehicleOperations = require('./Vehicle/vehicleOperations.js')
const payloadOperations = require('./Payload/payloadOperations.js')
const mailOperations = require('./Mailer/mailer.js')

//Setting the view engine to ejs
app.set('view engine','ejs')

//Setting up webserver
app.listen(4000, 'localhost', ()=>{
    console.log("Listening on port 4000")
})

app.use(cors())

//Routes configuration
app.use('/user',userOperations)
app.use('/location',locationOperations)
app.use('/device',deviceOperations)
app.use('/photos',imageOperations)
app.use('/vehicle/',vehicleOperations)
app.use('/payload',payloadOperations)
app.use('/mailer',mailOperations)
