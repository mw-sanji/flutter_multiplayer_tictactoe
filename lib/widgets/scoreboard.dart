import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    RoomDataProvider provider = Provider.of<RoomDataProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(provider.player1.nickname,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              ),
              Text(provider.player1.points.toString(),
              style: const TextStyle(
                fontSize: 20
              ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(provider.player2.nickname,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
              Text(provider.player2.points.toString(),
              style: const TextStyle(
                fontSize: 20
              )
              ),
            ],
          ),
        )
      ],
    );
  }
}