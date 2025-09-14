const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const db =require('../config/db');

const { Schema } = mongoose;

const userSchema = new Schema({
    email:{
        type:String,
        required: true,
        unique: true,
        lowercase: true
    },
    password:{
         type:String,
        required: true,
    }
});

userSchema.pre('save', async function() {
    try {
        var user = this;
        const salt = await bcrypt.genSalt(10);
        user.password = await bcrypt.hash(user.password, salt); 
    } catch (error) {
        throw error;
    }
})

userSchema.methods.comparePassword = async function(userPassword) {
    try {
        const isMatch = await bcrypt.compare(userPassword, this.password);
        return isMatch;
    } catch (error) {
        throw error;
    }
}


const userModel = db.model('User', userSchema);

module.exports = userModel;