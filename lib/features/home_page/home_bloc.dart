import 'dart:async';

import 'package:youtube_baonh/common/bases/base_event.dart';
import 'package:youtube_baonh/common/constants/variable_constant.dart';
import 'package:youtube_baonh/data/datasources/models/channel_model.dart';
import 'package:youtube_baonh/data/datasources/models/videos_response.dart';
import 'package:youtube_baonh/data/respositories/home_respository.dart';
import 'package:youtube_baonh/features/home_page/home_events.dart';

import '../../common/bases/base_bloc.dart';
import '../../data/datasources/models/video_model.dart';

class HomeBloc extends BaseBloc{
  late HomeRespository _homeRespository;
  StreamController<VideosResponse> _sliderStreamController = StreamController.broadcast();
  StreamController<VideosResponse> _vnTracksStreamController = StreamController.broadcast();
  StreamController<VideosResponse> _usTracksStreamController = StreamController.broadcast();
  StreamController<VideosResponse> _kpopTracksStreamController = StreamController.broadcast();
  StreamController<VideosResponse> _ukTracksStreamController = StreamController.broadcast();
  StreamController<List<Channel>> _singerChannelStreamController = StreamController.broadcast();

  List<Video> _sliderVideos = [];
  List<Video> _usTopTracksVideos = [];
  List<Video> _ukTopTracksVideos = [];
  List<Video> _kpopTopTracksVideos = [];
  List<Video> _vnTopTracksVideos = [];
  List<Channel> _singerChannels = [];
  List<Video> get sliderVideos => _sliderVideos;

  List<Channel> get singerChannels => _singerChannels;

  StreamController<VideosResponse> get sliderStreamController => _sliderStreamController;

  StreamController<VideosResponse> get vnTracksStreamController => _vnTracksStreamController;

  StreamController<VideosResponse> get usTracksStreamController => _usTracksStreamController;

  StreamController<VideosResponse> get kpopTracksStreamController => _kpopTracksStreamController;

  StreamController<VideosResponse> get ukTracksStreamController => _ukTracksStreamController;

  StreamController<List<Channel>> get singerChannelStreamController => _singerChannelStreamController;


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
      case LoadTrendingSingerChannelEvent:
        handleLoadTrendingSingerChannelEvent(event as LoadTrendingSingerChannelEvent);
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
    _usTracksStreamController.close();
    _kpopTracksStreamController.close();
    _ukTracksStreamController.close();
    _singerChannelStreamController.close();
  }

  void handleLoadTrendingMusicSliderEvent(LoadTrendingMusicSliderEvent event) async{
    try{
      List<Video> videos = await _homeRespository.getTrendingMusic(10);
      _homeRespository.getTopSingers(10);
      print("handleLoadTrendingMusicSliderEvent legth = ${videos.length}");
      if(videos.length > 0){
        VideosResponse videosResponse = VideosResponse();
        videosResponse.nameLayout = VariableConstant.LAYOUT_COMPO_SLIDER;
        videosResponse.videos = videos;
        _sliderVideos = videos;
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
        if(event.id == "VN"){
          print("VNN : length = ${videosResponse.videos.length}");
          _vnTopTracksVideos = videosResponse.videos;
          _vnTracksStreamController.add(videosResponse);
        }else if(event.id == "US"){
          _usTopTracksVideos = videosResponse.videos;
          _usTracksStreamController.add(videosResponse);
        }else if(event.id == "KR"){
            print("KRRRR : length = ${videosResponse.videos.length}");
            _kpopTopTracksVideos = videosResponse.videos;
          _kpopTracksStreamController.add(videosResponse);
        }else if(event.id == "UK"){
          _usTopTracksVideos = videosResponse.videos;
          _ukTracksStreamController.add(videosResponse);
        }

      }else{
        throw "videos length =0";
      }
    }catch(e){
      print("handleLoadCountryTracksEvent : error ${e.toString()}");
    }
  }

  List<Video> get usTopTracksVideos => _usTopTracksVideos;

  List<Video> get ukTopTracksVideos => _ukTopTracksVideos;

  List<Video> get kpopTopTracksVideos => _kpopTopTracksVideos;

  List<Video> get vnTopTracksVideos => _vnTopTracksVideos;

  void handleLoadTrendingSingerChannelEvent(LoadTrendingSingerChannelEvent event) async{
    try{
      List<Channel> channels = await _homeRespository.getTopSingers(event.maxResult);
      if(channels.length > 0){
        _singerChannels = channels;
        _singerChannelStreamController.add(channels);
      }else{
        throw "length =0";
      }
    }catch(e){
      print("handleLoadTrendingSingerChannelEvent : error : ${e.toString()}");
    }
  }
}