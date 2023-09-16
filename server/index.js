const express = require('express');
const http = require('http');
const mongoose = require('mongoose');
const app = express();
const Room = require('./models/room.js')
const port = process.env.PORT||3000;
var server=http.createServer(app);
var io = require('socket.io')(server);
app.use(express.json());
const DB = "mongodb://shreyans:shreyans77@ac-ufwga48-shard-00-00.qjzmbul.mongodb.net:27017,ac-ufwga48-shard-00-01.qjzmbul.mongodb.net:27017,ac-ufwga48-shard-00-02.qjzmbul.mongodb.net:27017/?ssl=true&replicaSet=atlas-9mlakc-shard-0&authSource=admin&retryWrites=true&w=majority";
io.on('connection', (socket)=> {
    console.log('connected');
    socket.on('createRoom',async ({nickname})=>{
        console.log(nickname);
        //creating a new room
        try{
            let room = new Room();
            //creating a new player with id,name and its type
            let player = {
                socketID : socket.id,
                nickname : nickname,
                playerType : 'X'
            }
            //pushing the player in the room created
            room.players.push(player);
    
            room.turn = player,
    
            //saving the room info in mongoDB
            room = await room.save();
            console.log(room);
    
            const roomID = room._id.toString();
            socket.join(roomID);
            io.to(roomID).emit('createRoomSuccess',room);
        } catch (e) {
            console.log(e);
        }
       
    });
    socket.on("joinRoom", async ({ nickname, roomId }) => {
        try {
          if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
            socket.emit("errorOccurred", "Please enter a valid room ID.");
            return;
          }
          let room = await Room.findById(roomId);
    
          if (room.isJoin) {
            let player = {
              socketID: socket.id,
              nickname,
              playerType: "O",
            };
            socket.join(roomId);
            room.players.push(player);
            room.isJoin = false;
            room = await room.save();
            io.to(roomId).emit("joinRoomSuccess", room);
            io.to(roomId).emit("updatePlayers", room.players);
            io.to(roomId).emit("updateRoom", room);
          } else {
            socket.emit(
              "errorOccurred",
              "The game is in progress, try again later."
            );
          }
        } catch (e) {
          console.log(e);
        }
      });
      socket.on("tap", async ({ index, roomId }) => {
        try {
          let room = await Room.findById(roomId);
    
          let choice = room.turn.playerType; // x or o
          if (room.turnIndex == 0) {
            room.turn = room.players[1];
            room.turnIndex = 1;
          } else {
            room.turn = room.players[0];
            room.turnIndex = 0;
          }
          room = await room.save();
          io.to(roomId).emit("tapped", {
            index,
            choice,
            room,
          });
        } catch (e) {
          console.log(e);
        }
      });
      socket.on("winner", async ({ winnerSocketId, roomId }) => {
        try {
          let room = await Room.findById(roomId);
          let player = room.players.find(
            (playerr) => playerr.socketID == winnerSocketId
          );
          player.points += 1;
          room = await room.save();
    
          if (player.points >= room.maxRounds) {
            io.to(roomId).emit("endGame", player);
          } else {
            io.to(roomId).emit("pointIncrease", player);
          }
        } catch (e) {
          console.log(e);
        }
      });
});
mongoose.connect(DB).then(()=>{
    console.log('connection successful');
}).catch((e)=>{
    console.log('e');
});
server.listen(port,'0.0.0.0',()=>{
    console.log('server started and running on port '+port);
});
