import 'dart:async';

import 'package:youtube_baonh/common/bases/base_bloc.dart';
import 'package:youtube_baonh/common/bases/base_event.dart';
import 'package:youtube_baonh/data/respositories/search_respository.dart';
import 'package:youtube_baonh/features/search_page/search_events.dart';

import '../../data/datasources/models/video_model.dart';

class SearchBloc extends BaseBloc{
  StreamController<List<Video>> _streamController = StreamController();

  StreamController<List<Video>> get streamController => _streamController;

  late SearchRespository _searchRespository;
  void updateSearchRespository(SearchRespository searchRespository){
    _searchRespository = searchRespository;
  }

  @override
  void dispatch(BaseEvent event) {
    // TODO: implement dispatch
    switch(event.runtimeType){
      case LoadRecommendKeywords:
        handleLoadRecommendKeywords(event as LoadRecommendKeywords);
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

  void handleLoadRecommendKeywords(LoadRecommendKeywords event) async{
    try{
      List<Video> videos = await _searchRespository.getKeywordsSearch();
      if(videos.length > 0){
        _streamController.add(videos);
      }
    }catch(e){
      print("handleLoadRecommendKeywords : error ${e.toString()}");
    }
  }
}