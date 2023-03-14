import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_baonh/common/bases/base_widget.dart';
import 'package:youtube_baonh/common/constants/variable_constant.dart';
import 'package:youtube_baonh/data/datasources/models/videos_response.dart';
import 'package:youtube_baonh/data/respositories/home_respository.dart';
import 'package:youtube_baonh/data/services/api_service.dart';
import 'package:youtube_baonh/features/home_page/home_bloc.dart';
import 'package:youtube_baonh/features/home_page/home_events.dart';

import '../../data/datasources/models/video_model.dart';
import '../components/square_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;
    final appBarWidth = MediaQuery.of(context).size.width;
    return PageContainer(child: HomeContainer(),
        providers: [
          Provider<APIService>(create: (context)=>APIService()),
          ProxyProvider<APIService, HomeRespository>(
              create: (context)=> HomeRespository(),
              update: (context,apiService,homeRespository){
                homeRespository?.updateAPIService(apiService);
                return homeRespository!;
              }),
          ProxyProvider<HomeRespository,HomeBloc>(
              create: (context)=>HomeBloc(),
              update: (context,homeRespository,homeBloc){
                homeBloc?.updateHomeRespository(homeRespository);
                return homeBloc!;
              })
        ],
    appBar: AppBar(
    ),
    isShowNavigationBar: true,);
  }
}

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  late HomeBloc _homeBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeBloc = context.read();
    _homeBloc.eventSink.add(LoadTrendingMusicSliderEvent());
    _homeBloc.eventSink.add(LoadCountryTracksEvent("VN", "vietnam music", VariableConstant.LAYOUT_COMPO_VN));
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width;
    double baseHeight = MediaQuery.of(context).size.height;
    return SafeArea(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(child: Container(
          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
          child: StreamBuilder<VideosResponse>(
            stream: _homeBloc.sliderStreamController.stream,
            builder: (context,snapshot){
              if(snapshot.hasError || snapshot.data == null ){
                return Container();
              }
              return _sliderTrendingWidget(snapshot.data!.videos,baseWidth);
            },
          ),
        ) ),
        Flexible(child: Container(
          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
          child: StreamBuilder<VideosResponse>(
            stream: _homeBloc.vnTracksStreamController.stream,
            builder: (context,snapshot){
              if(snapshot.hasError || snapshot.data == null ){
                return Container();
              }
              return _horizontalListVideo(snapshot.data!.videos);
            },
          ),
        ))
      ],
    ));
  }

  Widget _sliderTrendingWidget(List<Video> videos, double width){
    return Align(
      alignment: Alignment.topCenter,
      child: CarouselSlider(
        items: videos
            .map((item) => _sliderItem(item,width))
            .toList(),
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 1000),
          autoPlayCurve: Curves.fastOutSlowIn,
          viewportFraction: 1.0
        ),
      ),
    );
  }

  Widget _sliderItem(Video video,double width){
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 2.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(video.thumbnailUrl),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.transparent,
            ],
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              video.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

  }

  Widget _horizontalListVideo(List<Video> videos){
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: videos.length,
        itemBuilder: (context,index){
          return SquareWidget(videos[index]);
        });
  }
}

