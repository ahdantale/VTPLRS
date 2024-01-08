const mongoose = require('mongoose')

const mongooseSchema = mongoose.Schema
const mongooseModel = mongoose.model

const userSchema = new mongooseSchema({
    name : String,
    phoneNo : Number,
    email : { type : String, unique : true},
    age : Number,
    password : String,
    passwordResetToken : {
        type: String,
        strict: false
    }
})

const userModel = new mongooseModel('users',userSchema)

module.exports = {
    userModel : userModel
}