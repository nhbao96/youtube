import 'package:flutter/material.dart';
import 'package:youtube_baonh/features/home_page/home_screen.dart';

import 'features/player_page/Player_Page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: {
        "player-page": (context) => PlayerPage(),
        "home-screen": (context) =>HomeScreen()
      },
      initialRoute:  "home-screen",
    );
  }
}
