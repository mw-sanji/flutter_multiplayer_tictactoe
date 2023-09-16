import 'package:flutter/material.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/responsive/responsive.dart';
import 'package:tictactoe/widgets/custom_text.dart';
import 'package:tictactoe/widgets/custom_textfield.dart';

class CreateRoom extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final SocketMethods method = SocketMethods();
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    method.createRoomSuccessListener(context);
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
           text: "Create Room", 
           fontSize: 60),
           const SizedBox(height: 30),
           MyWidget(controller: controller, hintText: "Enter Your Nickname"),
           const SizedBox(height: 15),
           ElevatedButton(onPressed: (){
              method.createRoom(controller.text);
           }, child: Container(
            width: MediaQuery.of(context).size.width,
            height: 24,
            child: Center(  child: CustomText(shadows: [], text: "Create Room", fontSize: 15)),
           ) )
           ],
        ),
      ),
    ));
  }
}
