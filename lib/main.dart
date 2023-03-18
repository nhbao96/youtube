import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_baonh/features/home_page/home_page.dart';
import 'package:youtube_baonh/features/search_page/search_page.dart';


import 'features/channel_page/channel_page.dart';
import 'features/player_page/Player_Page.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
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
