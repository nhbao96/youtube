import 'package:youtube_baonh/common/bases/base_bloc.dart';
import 'package:youtube_baonh/common/bases/base_event.dart';
import 'package:youtube_baonh/data/respositories/topic_respository.dart';

class TopicBloc extends BaseBloc{
  late TopicRespository _topicRespository;

  void updateTopicRespository(TopicRespository topicRespository){
    _topicRespository = topicRespository;
  }

  @override
  void dispatch(BaseEvent event) {
    // TODO: implement dispatch
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

}