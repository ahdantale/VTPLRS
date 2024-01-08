const router = require('express').Router()
const jsonParser = require('body-parser').json()
const vehicleModel = require('../Schemas/VehicleSchema.js').vehicleModel

//Function to add vehicle details to database
async function addVehicleDetails(vehicle) {

    const newVehicle = new vehicleModel({
        make : vehicle.make,
        model : vehicle.model,
        colour : vehicle.colour,
        registration : vehicle.registration,
        email : vehicle.email
    })

    try {
        result = await newVehicle.save()
        return result
    } catch(err) {
        console.log(err)
        return false
    }

}

//Function to fetch details for vehicles
async function getVehicleDetails(email) {
    try {
        result = await vehicleModel.findOne(email).exec()
        console.log(result)
        return result
    } catch(err){
        console.log(err)
        return false
    }
}

//Route to add vehicle details
router.post('/addVehicle',jsonParser,async (req,res)=>{
    result = await addVehicleDetails(req.body)
    if(result){
        res.status(200).send("Vehicle added successfully")
    } else {
        res.status(500).send("Vehicle not added")
    }
})

//Route to fetch vehicle details
router.post('/getVehicle',jsonParser,async (req,res)=>{
    console.log(req.body)
    result = await getVehicleDetails(req.body)
    if(result){
        res.setHeader('Content-Type','application/json')
        res.status(200).json(result)
    } else {
        res.status(500).send('Vehicle not found')
    }
})

module.exports = router
