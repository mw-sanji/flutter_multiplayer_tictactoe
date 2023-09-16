import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/screens/createroom.dart';
import 'package:tictactoe/screens/game_screen.dart';
import 'package:tictactoe/screens/joinroom.dart';
import 'package:tictactoe/screens/main_screen.dart';
import 'package:tictactoe/utils/colors.dart';

void main()  {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        theme: ThemeData.dark(
        ).copyWith(
          scaffoldBackgroundColor: bgColor
        ),
        routes: {
          MainScreen.routeName:(context) => const MainScreen(),
          CreateRoom.routeName:(context) => const CreateRoom(),
          JoinRoom.routeName:(context) => const JoinRoom(),
          GameScreen.routeName:(context) => const GameScreen()
        },
        initialRoute: MainScreen.routeName,
        home: const MainScreen()
        ),
    );
  }
}