import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/game_methods.dart';
import 'package:tictactoe/resources/socket_client.dart';
import 'package:tictactoe/screens/game_screen.dart';
import 'package:tictactoe/utils/utils.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods {
  final  _instance = SocketClient.instance.socket!;
  Socket get instance => _instance;
  void createRoom (String name){
    if(name.isNotEmpty){
      _instance.emit('createRoom',{
        'nickname':name,
      });
    }
  }
  void joinRoom (String nickname ,String roomId){
    if(nickname.isNotEmpty&&roomId.isNotEmpty){
      _instance.emit('joinRoom',{
        'nickname':nickname,
        'roomId':roomId
      });
    }
  }
  void tapGrid (int index,String roomId,List<String> displayElements){
    if(displayElements[index]==''){
      _instance.emit('tap',{
        'index':index,
        'roomId':roomId
      });
    }
  }
  void createRoomSuccessListener (BuildContext context){
    _instance.on('createRoomSuccess', (room) {
      Navigator.pushNamed(context,GameScreen.routeName );
      Provider.of<RoomDataProvider>(context,listen: false).updateRoomData(room);
    });
  }
  void joinRoomSuccessListener (BuildContext context){
    _instance.on('joinRoomSuccess', (room)  {
      Navigator.pushNamed(context,GameScreen.routeName);
      Provider.of<RoomDataProvider>(context,listen: false).updateRoomData(room);
    });
  }
  void errorOccurredListener (BuildContext context){
    _instance.on('errorOccurred', (data) {
      showSnackbar(context, data);
    } );
  }
  void updatePlayerStateListener (BuildContext context){
    _instance.on('updatePlayers', (playerData) {
    Provider.of<RoomDataProvider>(context,listen: false).updatePlayer1(
      playerData[0],
      );
    Provider.of<RoomDataProvider>(context,listen: false).updatePlayer2(
      playerData[1],
      );
    } );
  }
  void updateRoomListener (BuildContext context){
    _instance.on("updateRoom", (room) {
    Provider.of<RoomDataProvider>(context,listen: false).updateRoomData(room);
    });
  }
  void tappedListener(BuildContext context) {
    _instance.on('tapped', (data) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      roomDataProvider.updateDisplayElements(
        data['index'],
        data['choice'],
      );
      roomDataProvider.updateRoomData(data['room']);
      // check winnner
      GameMethods().checkWinner(context, _instance);
    });
  }
  void increasePointsListener (BuildContext context){
    _instance.on('pointIncrease', (playerData) {
      var roomDataProvider = Provider.of<RoomDataProvider>(context,listen: false);
      if(playerData['socketID']==roomDataProvider.player1.socketID){
        roomDataProvider.updatePlayer1(playerData);
      }
      if(playerData['socketID']==roomDataProvider.player2.socketID){
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }
  void endGameListener (BuildContext context){
    _instance.on('endGame', (playerData) {
    showGameDialog(context, '${playerData['nickname']} won the game');
    Navigator.popUntil(context, (route) => false);
    });
  }
}