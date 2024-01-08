const router = require('express').Router()
const multer = require('multer')
const imageModel = require('../Schemas/ImageSchema.js').imageModel
const fs = require('fs')

//Function for loading the image in the database
var uploads = multer({
    dest : '../uploads'
})

//Route for the photos
router.post('/saveVehiclePhotos',uploads.any(),async function(req,res){
    try {
        var newImage = new imageModel()
        newImage.img.data = fs.readFileSync(req.files[0].path)
        newImage.img.contentType = 'image/png'
        newImage.type = req.body.type
        newImage.deviceId = req.body.deviceId
        await newImage.save()
        res.status(200).send('Image saved successfully')
    } catch(err) {
        console.log(err)
        res.status(500).send('Image not saved successfully')
    }
})

//Route to get photos from DB
router.get('/getPhoto/:deviceId',async (req,res)=>{
    try{
        result = await imageModel.findOne({deviceId : req.params.deviceId})
        if(!result){
            res.status(500).send('Image not found')
            return
        }
        var base64data = new Buffer(result.img.data,'binary').toString('base64')
        var responseJSON = {
            imageString : base64data,
            deviceId : req.params.deviceId
        }
        console.log(responseJSON)
        res.status(200).json(responseJSON)
    }catch(err){
        console.log(err)
        res.status(500).send('Image not found')
    }
})

module.exports = router