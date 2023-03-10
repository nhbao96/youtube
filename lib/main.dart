import 'package:flutter/material.dart';
import 'package:youtube_baonh/features/home_page/home_page.dart';
import 'package:youtube_baonh/features/search_page/search_page.dart';


import 'features/channel_page/channel_page.dart';
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
        "channel-page": (context) =>ChannelPage(),
        "search-page": (context)=> SearchPage(),
        "home-page": (context)=>HomePage()
      },
      initialRoute:  "home-page",
    );
  }
}
