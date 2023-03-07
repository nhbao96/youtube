import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../common/bases/base_widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return PageContainer(child: HomeContainer(), providers: [],
      appBar: AppBar(title: Text("Youtube"),),
    );
  }
}


class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  late YoutubePlayerController _controller;



  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    _controller =  YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=U9DAOyFyblA")!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        hideControls: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Player component
        Container(
          height: 200,
          color: Colors.grey,
          child: Center(
            child: PlayerWidget(),
          ),
        ),
        SizedBox(height: 16),
        // Related videos lane
        Text(
          'Related Videos',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10, // Change this to number of videos you want to display
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                ),
                title: Text('Video Title'),
                subtitle: Text('Channel Name'),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget PlayerWidget()
  {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true
      ),
      builder: (context, player) {
        return Column(
          children: [
            player,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    _controller.pause();
                  },
                  icon: Icon(Icons.pause),
                ),
                IconButton(
                  onPressed: () async {
                    _controller.play();

                  },
                  icon: Icon(Icons.play_arrow),
                ),
                IconButton(
                  onPressed: () {
                    _controller.seekTo(Duration.zero);
                    _controller.pause();
                  },
                  icon: Icon(Icons.stop),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

