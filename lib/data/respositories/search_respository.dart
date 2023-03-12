import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:youtube_baonh/data/datasources/models/video_model.dart';
import 'package:youtube_baonh/data/services/api_service.dart';

class SearchRespository{
  late APIService _apiService;

  void updateAPIService(APIService apiService){
    _apiService = apiService;
  }

  Future<List<Video>> getKeywordsSearch() async{
    Completer<List<Video>> completer = Completer();
    try{
      Response response = await _apiService.getTrendingKeywordsForSearch();
      print("SearchRespository : getKeywordsSearch : ${response.statusCode}");
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        List<dynamic> videosJson = data['items'];
        // Fetch first eight videos from uploads playlist
        List<Video> videos = [];
        videosJson.forEach(
              (json) => videos.add(
            Video.fromMapRelative(json),
          ),
        );
        completer.complete(videos);
      }
    }catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<List<Video>> searchVideo(String keyword) async{
    Completer<List<Video>> completer = Completer();
    try{
      Response response = await _apiService.searchVideo(keyword);
      print("SearchRespository : searchVideo : ${response.statusCode}");
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        List<dynamic> videosJson = data['items'];
        // Fetch first eight videos from uploads playlist
        List<Video> videos = [];
        videosJson.forEach(
              (json) => videos.add(
            Video.fromMapRelative(json),
          ),
        );
        completer.complete(videos);
      }
    }catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<List<Video>> autoComplete(String keyword) async{
    Completer<List<Video>> completer = Completer();
    try{
      Response response = await _apiService.autocomplete(keyword);
      print("SearchRespository : autoComplete : ${response.statusCode}");
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        List<dynamic> videosJson = data['items'];
        // Fetch first eight videos from uploads playlist
        List<Video> videos = [];
        videosJson.forEach(
              (json) => videos.add(
            Video.fromMapRelative(json),
          ),
        );
        completer.complete(videos);
      }
    }catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}