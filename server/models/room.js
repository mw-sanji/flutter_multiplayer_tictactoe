const mongoose = require('mongoose');
const playerSchema = require('./players');

const roomSchema = new mongoose.Schema({
    occupancy : {
        default : 2,
        type : Number
    },
    maxRounds : {
        default : 5,
        type : Number
    },
    currentRound : {
        required : true,
        type : Number,
        default : 1
    },
    players : [playerSchema],
    isJoin : {
        type : Boolean,
        default : true
    }, 
    turn : playerSchema,
    turnIndex : {
        type : Number,
        default : 0
    } 
})

const roomModel = mongoose.model('Room',roomSchema);
module.exports = roomModel;