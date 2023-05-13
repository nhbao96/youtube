import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_baonh/common/bases/base_widget.dart';
import 'package:youtube_baonh/data/respositories/topic_respository.dart';
import 'package:youtube_baonh/data/services/api_service.dart';
import 'package:youtube_baonh/features/topic_page/topic_bloc.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({Key? key}) : super(key: key);

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(child: TopicContainer(), providers: [
      Provider<APIService>(create: (context)=> APIService()),
      ProxyProvider<APIService,TopicRespository>(
          create: (context)=>TopicRespository(),
          update: (context,apiService,topicRespository){
            topicRespository?.updateApiService(apiService);
            return topicRespository!;
          }),
      ProxyProvider<TopicRespository,TopicBloc>(
          create: (context) => TopicBloc(),
          update: (context,topicRespository, topicBloc){
            topicBloc?.updateTopicRespository(topicRespository);
            return topicBloc!;
          })
    ]);
  }
}

class TopicContainer extends StatefulWidget {
  const TopicContainer({Key? key}) : super(key: key);

  @override
  State<TopicContainer> createState() => _TopicContainerState();
}

class _TopicContainerState extends State<TopicContainer> {
  late TopicBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = context.read();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

