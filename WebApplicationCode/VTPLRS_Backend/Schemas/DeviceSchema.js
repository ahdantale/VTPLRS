const mongoose = require('mongoose')

const mongooseSchema = mongoose.Schema
const mongooseModel = mongoose.model

const deviceSchema = new mongooseSchema({
    deviceId : { type : String, unique : true},
    email : { type : String, unique : true}
})

const deviceModel = new mongooseModel('devices',deviceSchema)

module.exports = {
    deviceModel : deviceModel
}