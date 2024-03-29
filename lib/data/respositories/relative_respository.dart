import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:youtube_baonh/data/datasources/models/video_model.dart';
import 'package:youtube_baonh/data/services/api_service.dart';

class RelativeRespository{

  late APIService _apiService;
  void updateAPIService(APIService apiService){
    _apiService = apiService;
  }

  Future<List<Video>> getListRelatedVideo(String idVideo) async {
    Completer<List<Video>> completer = Completer();
    try{
     Response response = await _apiService.getRelatedVideos(idVideo);
     if(response.statusCode == 200){
       var data = json.decode(response.body);

       List<dynamic> videosJson = data['items'];
       // Fetch first eight videos from uploads playlist
       List<Video> videos = [];
       videosJson.forEach(
             (json) => videos.add(
           Video.fromMapRelative(json),
         ),
       );
       print("RelativeRespository list videos = ${videos.length}");
       completer.complete(videos);
     }else{
       throw response.statusCode;
     }
    }catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }


}