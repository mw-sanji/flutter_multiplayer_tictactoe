import 'package:flutter/material.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/responsive/responsive.dart';
import 'package:tictactoe/widgets/custom_text.dart';
import 'package:tictactoe/widgets/custom_textfield.dart';

class JoinRoom extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoom({super.key});

  @override
  State<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();
  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccurredListener(context);
    _socketMethods.updatePlayerStateListener(context);
  }
  @override
   Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(shadows: [
              Shadow(
                blurRadius: 40,
                color: Colors.blue
              )
            ],
           text: "Join Room", 
           fontSize: 60),
           const SizedBox(height: 30),
           MyWidget(controller: controller1, hintText: "Enter Your Nickname"),
           const SizedBox(height: 15),
           MyWidget(controller: controller2, hintText: "Enter Room ID"),
           const SizedBox(height: 20),
           ElevatedButton(onPressed: (){
              _socketMethods.joinRoom(controller1.text, controller2.text);
           }, child: Container(
            width: MediaQuery.of(context).size.width,
            height: 24,
            child: Center(  child: CustomText(shadows: [], text: "Join Room", fontSize: 15)),
           ) )
           ],
        ),
      ),
    ));
  }
}