const router = require('express').Router()
const jsonParser = require('body-parser').json()
const deviceModel = require('../Schemas/DeviceSchema.js').deviceModel

//Function to register a device
async function registerDevice(device) {
    const newDevice = new deviceModel({
        deviceId : device.deviceId,
        email : device.email
    })
    try {
        result = await newDevice.save()
        return result
    } catch(err) {
        return false
    }
}

//Function to get the deviceId for an email
async function getDeviceInfo(email) {
    const result = await deviceModel.findOne(email).exec()
    if(result){
        return result
    } else {
        return null
    }
}

//Route to register the device
router.post('/registerDevice',jsonParser,async (req,res)=>{
    result = await registerDevice(req.body)
    if(result){
        res.status(200).send('Device registered successfully')
    }else{
        res.status(500).send('Device not registered')
    }
})

//Route to get the device id for the user
router.post('/getDeviceInfo',jsonParser,async (req,res)=> {
    const result = await getDeviceInfo(req.body)
    if(result){
        res.status(200).send(JSON.stringify(result))
    } else {
        res.status(500).send("Device not found")
    }
})

//Exporting the router function
module.exports = router