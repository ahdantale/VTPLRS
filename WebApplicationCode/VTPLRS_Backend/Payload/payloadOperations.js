const router = require('express').Router()

router.get('/getComplaintFormat',(req,res)=>{
    console.log('Download request received')
    res.download('./payloads/complaintformat.pdf')
})

module.exports = router