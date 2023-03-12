import 'dart:async';

import 'package:youtube_baonh/common/bases/base_bloc.dart';
import 'package:youtube_baonh/common/bases/base_event.dart';
import 'package:youtube_baonh/data/datasources/models/search_model.dart';
import 'package:youtube_baonh/data/respositories/search_respository.dart';
import 'package:youtube_baonh/features/search_page/search_events.dart';

import '../../data/datasources/models/video_model.dart';

class SearchBloc extends BaseBloc{
  StreamController<SearchModel> _streamController = StreamController();
  SearchModel _model = SearchModel(0, []);
  StreamController<SearchModel> get streamController => _streamController;

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
      case SearchWithKeywordEvent:
        handleSearchWithKeywordEvent(event as SearchWithKeywordEvent);
        break;
      case AutoCompleteKeywordsEvent:
        handleAutoCompleteKeywordsEvent(event as AutoCompleteKeywordsEvent);
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
      _model.videos = await _searchRespository.getKeywordsSearch();
      if( _model.videos.length > 0){
        _model.typeDisplay = 0;
        _streamController.add(_model);
      }
    }catch(e){
      print("handleLoadRecommendKeywords : error ${e.toString()}");
    }
  }

  void handleSearchWithKeywordEvent(SearchWithKeywordEvent event) async{
    try{
      _model.videos =await _searchRespository.searchVideo(event.keyword);
      if(_model.videos.length > 0){
        _model.typeDisplay = 1;
        _streamController.add(_model);
      }
    }catch(e){
    print("handleSearchWithKeywordEvent : error ${e.toString()}");
    }
  }

  void handleAutoCompleteKeywordsEvent(AutoCompleteKeywordsEvent event) async{
    try{
      _model.videos = await _searchRespository.searchVideo(event.keyword);
      if(_model.videos.length > 0){
        _model.typeDisplay = 0;
        _streamController.add(_model);
      }
    }catch(e){
      print("handleAutoCompleteKeywordsEvent : error ${e.toString()}");
    }
  }
}