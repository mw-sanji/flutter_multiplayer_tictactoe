import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/responsive/responsive.dart';
import 'package:tictactoe/screens/createroom.dart';
import 'package:tictactoe/screens/joinroom.dart';

class MainScreen extends StatelessWidget {
  static String routeName = '/main-menu';
  const MainScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: Responsive(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Tic Tac Toe!!!',
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed:() {
                      Navigator.pushNamed(context, CreateRoom.routeName);
                    },
                    child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text(
                          "Create Room",
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(fontSize: 22)),
                        )))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, JoinRoom.routeName);
                    },
                    child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text(
                          "Join Room",
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(fontSize: 22)),
                        )))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {},
                    child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text(
                          "New Game",
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(fontSize: 22)),
                        )))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
