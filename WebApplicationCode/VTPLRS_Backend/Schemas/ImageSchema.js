const mongoose = require('mongoose')

const mongooseSchema = mongoose.Schema
const mongooseModel = mongoose.model

const imageSchema = new mongooseSchema({
    img :{ data : Buffer, contentType : String},
    type : String,
    deviceId : String
})

const imageModel = new mongooseModel('Images',imageSchema)

module.exports = {
    imageModel : imageModel
}