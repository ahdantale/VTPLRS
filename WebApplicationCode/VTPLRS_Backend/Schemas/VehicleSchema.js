const mongoose = require('mongoose')

const mongooseSchema = mongoose.Schema
const mongooseModel = mongoose.model

const vehicleSchema = new mongooseSchema({
    make : String,
    model : String,
    colour : String,
    registration : String,
    email : String
})

const vehicleModel = new mongooseModel('vehicles',vehicleSchema)

module.exports = {
    vehicleModel : vehicleModel
}