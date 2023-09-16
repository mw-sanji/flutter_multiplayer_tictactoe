import 'package:flutter/material.dart';
import 'package:tictactoe/models/players.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String,dynamic> _roomData = {};
  Player _player1 = Player(nickname: "", socketID: '', points: 0, playerType:'X');
  Player _player2 = Player(nickname: "", socketID: '', points: 0, playerType:'0');
  List<String> _displayElements = ['','','','','','','','','',];
  int _filledBoxes = 0;

  Map<String,dynamic> get roomData => _roomData;
  Player get player1 => _player1;
  Player get player2 => _player2;
  List<String> get displayElements => _displayElements;
  int get filledBoxes => _filledBoxes;

  void updateRoomData (Map <String,dynamic> data){
    _roomData = data;
    notifyListeners();
  }
  void updatePlayer1 (Map<String,dynamic> player1Data){
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }
    void updatePlayer2 (Map<String,dynamic> player2Data){
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }
    void updateDisplayElements (int index,String choice){
      _displayElements[index]= choice;
      _filledBoxes+=1;
      notifyListeners();
    }
    void setFilledBoxesTo0 (){
      _filledBoxes = 0;
      notifyListeners();
    }
}