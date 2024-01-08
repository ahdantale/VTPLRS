const router = require('express').Router()
const jsonParser = require('body-parser').json()
const locationDataModel = require('../Schemas/LocationSchema.js').locationDataModel

//Function to add location for a device
async function addLocation(location) {
    var dateAtLocation = new Date()
    console.log(location)
    const newLocation = new locationDataModel({
        lat : location.lat,
        long : location.long,
        deviceId : location.deviceId,
        timeStamp : dateAtLocation
    })
    try {
        result = await newLocation.save()
        return result
    } catch(err) {
        console.log(err)
        return false
    }
}

//Function to get the locations for a particular device
async function getLocationsForDevice(device) {
    try {
        result = await locationDataModel.find(device).exec()
        var resultToSort = result
        var sortedResult = resultToSort.sort((a,b)=>b.date-a.date)
        return sortedResult
    } catch(err) {
        console.log(err)
        return false
    }
}

//Routes
router.post('/addLocation', jsonParser, async (req,res)=>{
    console.log(req)
    console.log(req.body)
    result = await addLocation(req.body)
    if(result){
        res.status(200).send('Location added successfully')
    }else{
        res.status(500).send('Location not added')
    }
})

router.post('/getLocationForDevice', jsonParser, async (req,res)=>{
    result = await getLocationsForDevice(req.body)
    if(result.length>0){
        res.status(200).send(JSON.stringify(result))
    } else {
        res.status(500).send('Locations not found')
    }
})

module.exports = router
