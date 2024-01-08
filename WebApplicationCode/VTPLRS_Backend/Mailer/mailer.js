const router = require('express').Router()
const nodemailer = require('nodemailer')
const jwt = require('jwt-simple')
const bodyParser = require('body-parser').urlencoded({extended:false})
const bcrypt = require('bcrypt')
const userModel = require('../Schemas/UserSchema').userModel
const saltRounds = 10

//Function to create the jwt to be loaded in the email
function generateJWT(userid,emailid,hashedSecret) {
    const payload = {
        userid : userid,
        email : emailid
    }

    const secret = hashedSecret
    const token = jwt.encode(payload,secret)
    return token
}

//Configuring SMTP for nodemailer
let transport = nodemailer.createTransport({
    host: "smtp.mailtrap.io",
    port: 2525,
    auth: {
        user: "ef439e7658f40b",
        pass: "7850d301e36769"
    }
});

//User bodyparser
router.use(bodyParser)

//Route to send the mail
router.get('/recoverPassword', async (req, res) => {
    //Configuring the email
    const queryObject = {"email":req.query.emailid}
    try {
        const user = await userModel.findOne(queryObject).exec()
        if (user) {
            try {
                const userid = user._id
                const token = generateJWT(userid,req.query.emailid,user.password)
                try {
                    await userModel.findByIdAndUpdate({"_id":userid},{ "passwordResetToken":token}).exec()
                } catch (err) {
                    console.log("5",err)
                    res.send("email not set")
                }
                const linkToBeMailed = "http://localhost:4000/mailer/finalpasswordRecovery/"+token
                const message = {
                    from: "test@VTPLRS.com",
                    to: req.query.emailid,
                    subject: "Password Reset Email : VTPLRS",
                    html : "<p>Up The Arsenal!! Your password reset link is</p>" +"<a href="+linkToBeMailed+">Click here to reset password.</a>"
                }
                try {
                    const result = await transport.sendMail(message)
                    console.log("4",result)
                    res.send(result)
                } catch(err){
                    console.log("3",err)
                    res.send('Not done')
                }
                
            } catch (err) {
                console.log("2",err)
                res.send('Sending of email Not Done')
            }

        } else {
            res.send('User not found')
        }
    } catch (err) {
        console.log("1",err)
        res.send('Not found')
    }
})

//Route to render the password recovery page
router.get('/finalPasswordRecovery/:token',async (req,res)=>{
    const token = req.params.token
    
    try {
        const userFromId = await userModel.findOne({"passwordResetToken":token}).exec()
        if(userFromId){
            res.render('passwordRecovery',{token:token})
        } else {
            res.send("Forbidden")
        }
    }catch(err) {
        res.send("User not found")
    }
    
})

router.post('/updatePassword',async (req,res)=>{
    console.log(req.body)
    const token = req.body.token
    const newPassword = req.body.password
    const salt = await bcrypt.genSalt(saltRounds)
    const hashedPassword = await bcrypt.hash(newPassword, salt)
    try {
        let userFromId = await userModel.findOne({"passwordResetToken":token}).exec()
        userFromId.password = hashedPassword
        userFromId.passwordResetToken = undefined
        userFromId.save((err)=>{
            if(err) {
                res.send("Password updation failed")
            } else {
                res.send("Password updation successfull")
            }
        })
    } catch(err) {
        console.log(err)
        res.send("Internal error")
    }
})



module.exports = router

//http://localhost:4000/mailer/recoverPassword/?emailid=rafaleArsenal@gmail.com => Query String