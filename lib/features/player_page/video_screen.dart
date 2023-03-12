import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_baonh/common/bases/base_widget.dart';
import 'package:youtube_baonh/data/datasources/models/video_model.dart';
import 'package:youtube_baonh/data/respositories/relative_respository.dart';
import 'package:youtube_baonh/data/services/api_service.dart';
import 'package:youtube_baonh/features/player_page/relative_bloc.dart';
import 'package:youtube_baonh/features/player_page/relative_events.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreenPage extends StatefulWidget {
  final Video _video;
  VideoScreenPage(this._video);

  @override
  State<VideoScreenPage> createState() => _VideoScreenPageState();
}

class _VideoScreenPageState extends State<VideoScreenPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
        child: VideoScreenContainer(widget._video),
        providers: [
          Provider(create: (context)=>APIService()),
          ProxyProvider<APIService,RelativeRespository>(
              create: (context)=>RelativeRespository(),
              update: (context,apiService, relativeRespository){
                relativeRespository?.updateAPIService(apiService);
                return relativeRespository!;
              }),
          ProxyProvider<RelativeRespository,RelativeBloc>(
              create: (context)=>RelativeBloc(),
              update: (context,relativeRespository,relativeBloc){
                relativeBloc?.updateRelativeRespository(relativeRespository);
                return relativeBloc!;
              })
        ],
     );
  }
}


class VideoScreenContainer extends StatefulWidget {

  final Video _video;

  VideoScreenContainer(this._video);

  @override
  _VideoScreenContainerState createState() => _VideoScreenContainerState();
}

class _VideoScreenContainerState extends State<VideoScreenContainer> {

  late YoutubePlayerController _controller;
  late RelativeBloc _relativeBloc;
  @override
  void initState()  {
    super.initState();
    _relativeBloc = context.read();
    _initPlayer();
    _relativeBloc.eventSink.add(LoadRelatedVideos(widget._video.id));
  }

  void _initPlayer() {
    _controller =  YoutubePlayerController(
      initialVideoId: widget._video.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Stack(
      children: [
        Column(
          children: [
            Expanded(child: Container()),
            Expanded(flex: 2,
              child: StreamBuilder<List<Video>>(
                stream: _relativeBloc.streamController.stream,
                builder: (context, snapshot) {
                  if(snapshot.hasError || snapshot.data == null){
                    return Container();
                    }
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return relatedVideoWidget(snapshot.data![index]);
                    },
                  );
                }
              ),
            )
          ],
        ),
        playerWidget()
      ],
    ));
  }

  Widget playerWidget(){
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      onReady: () {
        print('Player is ready.');
      },
    );
  }
  Widget relatedVideoWidget(Video video){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      padding: EdgeInsets.all(10.0),
      height: 140.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Image(
            width: 150.0,
            image: NetworkImage(video.thumbnailUrl),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              video.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

}