import 'dart:async';

import 'package:youtube_baonh/common/bases/base_bloc.dart';
import 'package:youtube_baonh/common/bases/base_event.dart';
import 'package:youtube_baonh/data/datasources/models/video_model.dart';
import 'package:youtube_baonh/data/respositories/relative_respository.dart';
import 'package:youtube_baonh/features/player_page/relative_events.dart';

class RelativeBloc extends BaseBloc{
  StreamController<List<Video>> _streamController = StreamController();
  late RelativeRespository _respository;
  late List<Video> _model;

  StreamController<List<Video>> get streamController => _streamController;
  List<Video> get model => _model;
  void updateRelativeRespository(RelativeRespository relativeRespository){
    _respository = relativeRespository;
  }
  @override
  void dispatch(BaseEvent event) {
    // TODO: implement dispatch
    switch(event.runtimeType){
      case LoadRelatedVideos:
        handleLoadRelatedVideo(event as LoadRelatedVideos);
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

  void handleLoadRelatedVideo(LoadRelatedVideos event) async{
    print("\n\n\nBloc : handleLoadRelatedVideo");
    try{
      _model = await _respository.getListRelatedVideo(event.idVideo);
      _streamController.add(_model);
    }catch(e){
      print("handleLoadRelatedVideo : ${e.toString()}");
    }
  }


}