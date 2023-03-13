import 'dart:async';

import 'package:youtube_baonh/common/bases/base_event.dart';
import 'package:youtube_baonh/data/respositories/home_respository.dart';
import 'package:youtube_baonh/features/home_page/home_events.dart';

import '../../common/bases/base_bloc.dart';
import '../../data/datasources/models/video_model.dart';

class HomeBloc extends BaseBloc{
  late HomeRespository _homeRespository;
  StreamController<List<Video>> _streamController = StreamController();


  StreamController<List<Video>> get streamController => _streamController;

  void updateHomeRespository(HomeRespository homeRespository){
    _homeRespository = homeRespository;
  }
  @override
  void dispatch(BaseEvent event) {
    // TODO: implement dispatch
    switch(event.runtimeType){
      case LoadTrendingMusicSliderEvent:
        handleLoadTrendingMusicSliderEvent(event as LoadTrendingMusicSliderEvent);
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

  void handleLoadTrendingMusicSliderEvent(LoadTrendingMusicSliderEvent event) async{
    try{
      List<Video> videos = await _homeRespository.getTrendingMusic(10);
      print("handleLoadTrendingMusicSliderEvent legth = ${videos.length}");
      if(videos.length > 0){
        _streamController.add(videos);
      }
    }catch(e){
      print("handleLoadTrendingMusicSliderEvent : error ${e.toString()}");
    }
  }
}