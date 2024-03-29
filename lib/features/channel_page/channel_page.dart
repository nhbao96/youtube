import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_baonh/common/bases/base_widget.dart';
import 'package:youtube_baonh/features/channel_page/channel_%20bloc.dart';
import 'package:youtube_baonh/features/channel_page/channel_event.dart';

import '../../data/datasources/models/channel_model.dart';
import '../../data/datasources/models/video_model.dart';
import '../../data/respositories/channel_respository.dart';
import '../../data/services/api_service.dart';
import '../player_page/video_screen.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({Key? key}) : super(key: key);

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: ChannelContainer(),
      providers: [
        Provider<APIService>(create: (context) => APIService()),
        ProxyProvider<APIService, ChannelRespository>(
          create: (context) => ChannelRespository(),
          update: (context, apiService, channelRespository) {
            channelRespository?.updateAPIService(apiService);
            return channelRespository!;
          },
        ),
        ProxyProvider<ChannelRespository, ChannelBloc>(
          create: (context) => ChannelBloc(),
          update: (context, channelRespository, channelBloc) {
            channelBloc?.updateChannelRespository(channelRespository);
            return channelBloc!;
          },
        )
      ],
      appBar: AppBar(backgroundColor: Colors.black),
      isShowNavigationBar: true,
      indexSelectedNavigation: 0,
    );
  }
}

class ChannelContainer extends StatefulWidget {
  @override
  _ChannelContainerState createState() => _ChannelContainerState();
}

class _ChannelContainerState extends State<ChannelContainer> {
  late ChannelBloc _bloc;
  bool _isLoading = false;
  late Channel _channel;
  late bool _isLoadPage;
  late String _idChannel;

  @override
  void initState() {
    print("initState");
    super.initState();
    //  _initChannel();
    _isLoadPage = false;

    _bloc = context.read();
    _idChannel = "";


  }

  _buildProfileInfo() {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      height: null,
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.deepOrange,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.0,
            backgroundImage: NetworkImage(_channel.profilePictureUrl),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  _channel.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10,left: 10),
                child: Text(
                  '${_channel.subscriberCount} subscribers',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,

                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreenPage(video),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
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
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(!_isLoadPage){
      final Map<String, dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

      _idChannel = args['idChannel'];

      _bloc.eventSink.add(LoadChannelEvent(_idChannel));
      _isLoadPage = true;
    }


    return SafeArea(
        child: StreamBuilder<Channel>(
      stream: _bloc.streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError || snapshot.data == null) {
          return Container();
        }
        _channel = _bloc.channel;
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollDetails) {
            if (!_isLoading &&
                _channel.videos.length != int.parse(_channel.videoCount) &&
                scrollDetails.metrics.pixels ==
                    scrollDetails.metrics.maxScrollExtent) {
              _bloc.eventSink.add(LoadChannelEvent(_idChannel));
            }
            return false;
          },
          child: ListView.builder(
            itemCount: 1 + _channel.videos.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return _buildProfileInfo();
              }
              Video video = _channel.videos[index - 1];
              return _buildVideo(video);
            },
          ),
        );
      },
    ));
  }
}
