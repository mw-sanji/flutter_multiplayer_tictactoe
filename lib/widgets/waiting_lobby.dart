import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/widgets/custom_textfield.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late TextEditingController controller;
  @override
  void initState() {
    // TODO: implement initState
    controller = TextEditingController(
      text: Provider.of<RoomDataProvider>(context,listen: false).roomData['_id']
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Waiting'),
        SizedBox(height: 20,),
        MyWidget(controller: controller, hintText: '',isReadOnly: true,),
        
      ],
    );
  }
}