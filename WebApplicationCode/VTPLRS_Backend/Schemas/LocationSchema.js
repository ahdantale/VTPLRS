const mongoose = require('mongoose')

const mongooseSchema = mongoose.Schema
const mongooseModel = mongoose.model

//Location Collection
const locationsSchema = mongooseSchema({
    lat : String,
    long : String,
    deviceId : String,
    timeStamp : Date
})

const locationDataModel = mongooseModel('Locations',locationsSchema)

module.exports = {
    locationDataModel : locationDataModel
}