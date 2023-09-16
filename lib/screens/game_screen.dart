import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/widgets/board.dart';
import 'package:tictactoe/widgets/scoreboard.dart';
import 'package:tictactoe/widgets/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  SocketMethods method = SocketMethods();
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    method.updateRoomListener(context);
    method.updatePlayerStateListener(context);
    method.increasePointsListener(context);
    method.endGameListener(context);
  }
  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      body: roomProvider.roomData['isJoin'] ? const WaitingLobby() :  SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           const ScoreBoard(),
           const TicTacToeBoard(),
           Text('${roomProvider.roomData['turn']['nickname']}\'s turn')
          ],
        )
        )
    );
  }
}
