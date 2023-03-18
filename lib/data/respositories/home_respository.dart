import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:youtube_baonh/data/datasources/models/video_model.dart';
import 'package:youtube_baonh/data/services/api_service.dart';

import '../../common/constants/variable_constant.dart';
import '../datasources/models/videos_response.dart';

class HomeRespository {
  late APIService _apiService;
  void updateAPIService(APIService apiService){
    _apiService = apiService;
  }
  
  Future<List<Video>> getTrendingMusic(int maxResult) async{
    Completer<List<Video>> completer = Completer();
    try{
      Response response = await _apiService.getTrendingMusicVideos(10);
      if(response.statusCode == 200){
        var data = json.decode(response.body);

        List<dynamic> videosJson = data['items'];

        // Fetch first eight videos from uploads playlist
        List<Video> videos = [];
        videosJson.forEach(
              (json) => videos.add(
            Video.fromMapTrendingMusic(json),
          ),
        );
        completer.complete(videos);
      }else{
        throw "HomeRespository getTrendingMusic : statusCode = ${response.statusCode}";
      }
    }catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<VideosResponse> getCountryTracks(String country, String queryKey, int maxResult) async{
    Completer<VideosResponse> completer = Completer();
    try{
      Response response = await _apiService.getTopTrackMusic(country, queryKey, maxResult);
      if(response.statusCode == 200){
        var data = json.decode(response.body);
        VideosResponse model = VideosResponse();
        model.id=country;
        List<dynamic> videosJson = data['items'];

        // Fetch first eight videos from uploads playlist
        List<Video> videos = [];
        List<String> videoIds = [];
        for(int i = 0; i < videosJson.length;i++){
          videos.add(Video.fromMapRelative(videosJson[i]));
          videoIds.add(videos[i].id);
        }
        model.videos = await getDetailOfTopTracks(videoIds);

        completer.complete(model);
      }else{
        throw response.statusCode;
      }
    }catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<List<Video>> getDetailOfTopTracks(List<String> ids) async{
    Completer<List<Video>> completer = Completer();
    try{
      Response response = await _apiService.getDetailOfTopTracks(ids);
      if(response.statusCode == 200){
        var data = json.decode(response.body);

        List<dynamic> videosJson = data['items'];
        List<Video> videos = [];
        videosJson.forEach(
              (json) => videos.add(
            Video.fromMapTrendingMusic(json),
          ),
        );
        completer.complete(videos);
      }else{
        throw "getDetailOfTopTracks : ${response.statusCode}";
      }
    }catch(e){
      completer.completeError(e);
    }
    return completer.future;
  }
}