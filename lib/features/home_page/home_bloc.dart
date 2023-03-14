import 'dart:async';

import 'package:youtube_baonh/common/bases/base_event.dart';
import 'package:youtube_baonh/common/constants/variable_constant.dart';
import 'package:youtube_baonh/data/datasources/models/videos_response.dart';
import 'package:youtube_baonh/data/respositories/home_respository.dart';
import 'package:youtube_baonh/features/home_page/home_events.dart';

import '../../common/bases/base_bloc.dart';
import '../../data/datasources/models/video_model.dart';

class HomeBloc extends BaseBloc{
  late HomeRespository _homeRespository;
  StreamController<VideosResponse> _sliderStreamController = StreamController();
  StreamController<VideosResponse> _vnTracksStreamController = StreamController();

  StreamController<VideosResponse> get sliderStreamController => _sliderStreamController;

  StreamController<VideosResponse> get vnTracksStreamController => _vnTracksStreamController;

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
      case LoadCountryTracksEvent:
        handleLoadCountryTracksEvent(event as LoadCountryTracksEvent);
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _sliderStreamController.close();
    _vnTracksStreamController.close();
  }

  void handleLoadTrendingMusicSliderEvent(LoadTrendingMusicSliderEvent event) async{
    try{
      List<Video> videos = await _homeRespository.getTrendingMusic(10);

      print("handleLoadTrendingMusicSliderEvent legth = ${videos.length}");
      if(videos.length > 0){
        VideosResponse videosResponse = VideosResponse();
        videosResponse.nameLayout = VariableConstant.LAYOUT_COMPO_SLIDER;
        videosResponse.videos = videos;
        _sliderStreamController.add(videosResponse);
      }
    }catch(e){
      print("handleLoadTrendingMusicSliderEvent : error ${e.toString()}");
    }
  }

  void handleLoadCountryTracksEvent(LoadCountryTracksEvent event) async{
    try{
      VideosResponse videosResponse = await _homeRespository.getCountryTracks(event.id, event.queryKey, 20);
      print("handleLoadCountryTracksEvent legth = ${videosResponse.videos.length}");
      if(videosResponse.videos.length>0){
        _vnTracksStreamController.add(videosResponse);
      }else{
        throw "videos length =0";
      }
    }catch(e){
      print("handleLoadCountryTracksEvent : error ${e.toString()}");
    }
  }
}