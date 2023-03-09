import 'dart:async';

import 'package:youtube_baonh/common/bases/base_bloc.dart';
import 'package:youtube_baonh/common/bases/base_event.dart';
import 'package:youtube_baonh/features/channel_page/channel_event.dart';

import '../../data/datasources/models/channel_model.dart';
import '../../data/respositories/channel_respository.dart';

class ChannelBloc extends BaseBloc{
  late ChannelRespository _channelRespository;
  StreamController<Channel> _streamController = StreamController();
  Channel? _channel;

  StreamController<Channel> get streamController => _streamController;

  Channel get channel => _channel ?? Channel(id: "", title: "", profilePictureUrl: "", subscriberCount: "", videoCount: "0", uploadPlaylistId: "", videos: []);

  void updateChannelRespository(ChannelRespository channelRespository){
    _channelRespository = channelRespository;
  }

  @override
  void dispatch(BaseEvent event) {
    // TODO: implement dispatch
  switch(event.runtimeType){
    case LoadChannelEvent:
      handleLoadChannelEvent(event as LoadChannelEvent);
      break;
    default:
      break;
  }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  void handleLoadChannelEvent(LoadChannelEvent event) async{
    try{
      _channel = await _channelRespository.getChannel(event.channelId);
      _streamController.add(_channel!);
    }catch(e){
      print("handleLoadChannelEvent : error ${e.toString()}");
    }
  }


}