const router = require('express').Router()
const userModel = require('../Schemas/UserSchema.js').userModel
const jsonParser = require('body-parser').json()
const bcrypt = require('bcrypt')
const saltRounds = 10

//Function to create a user
async function createUser(user){
    const salt = await bcrypt.genSalt(saltRounds)
    const hashedPassword = await bcrypt.hash(user.password, salt)

    const newUser = new userModel({
        name : user.name,
        phoneNo : user.phoneNo,
        email : user.email,
        age : user.age,
        password : hashedPassword
    })
    try {
        result = await newUser.save()
        return true
    } catch (err) {
        return false
    }
}

//Function to login a user
async function loginUser(user) {
    try {
        const anotherResult = await userModel.findOne({"email":user.email}).exec()
        const result = await bcrypt.compare(user.password,anotherResult.password)
        console.log("Password result",result)
        if(result){
            const objectToSend = {
                name : anotherResult.name,
                email : anotherResult.email,
                phoneNo : anotherResult.phoneNo,
                age : anotherResult.age
            }
            return objectToSend
        } else {
            return false
        }
    } catch(err){
        return false
    }
}

//Function to get user data
async function getUserData(user) {
    try {
        result = await userModel.findOne(user, 'name email phoneNo age').exec()
        console.log(result)
        return result
    } catch (err) {
        return false
    }
}

//Route to create user
router.post('/createUser',jsonParser, async (req,res)=>{
    result = await createUser(req.body)
    if(result) {
        res.status(200).send('User created successfully')
    } else {
        res.status(500).send('User creating failed')
    }
})

//Route to login user
router.post('/loginUser',jsonParser,async (req,res)=>{
    //Send passwrod and email id
    console.log("Request body",req.body)
    result = await loginUser(req.body)
    if(result){
        res.setHeader('Content-Type', 'application/json')
        res.status(200).send(JSON.stringify(result))
    } else {
        res.status(500).send('User not found')
    }
})

router.post('/getUser',jsonParser, async (req,res)=>{
    result = await getUserData(req.body)
    if(result){
        res.setHeader('Content-Type', 'application/json')
        res.status(200).send(JSON.stringify(result))
    } else {
        res.status(500).send('User not found')
    }
})

//Exporting router middleware function
module.exports = router