import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/socket_methods.dart';

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({super.key});

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  SocketMethods method = SocketMethods();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    method.tappedListener(context);
  }
  void tapped (int index,RoomDataProvider roomDataProvider){
    method.tapGrid(index, roomDataProvider.roomData['_id'], roomDataProvider.displayElements);
  }
  
  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height*0.7,
        maxWidth: 500
      ),
      child: AbsorbPointer(
        absorbing: roomDataProvider.roomData['turn']['socketID']!=method.instance.id,
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                tapped(index,roomDataProvider);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24),
                ),
                child: Center(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: Text(roomDataProvider.displayElements[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 100,
                      shadows: [
                        roomDataProvider.displayElements[index]=='O' ? const Shadow(
                          blurRadius: 40,
                          color: Colors.red 
                        ) : const Shadow(
                          blurRadius: 40,
                          color: Colors.blue 
                        )
                      ]
                    ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}