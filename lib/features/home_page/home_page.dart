import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_baonh/common/bases/base_widget.dart';
import 'package:youtube_baonh/common/constants/variable_constant.dart';
import 'package:youtube_baonh/data/datasources/models/videos_response.dart';
import 'package:youtube_baonh/data/respositories/home_respository.dart';
import 'package:youtube_baonh/data/services/api_service.dart';
import 'package:youtube_baonh/features/components/grid_video_widget.dart';
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
      backgroundColor: Colors.black,
      centerTitle: true,
     title:  Container(
       width: 300,
       height: 50,
       child: TextField(

         decoration: InputDecoration(
           hintText: "Search...",
           border: OutlineInputBorder(),
         ),
         onChanged: (value){

         },
         onSubmitted: (value){
           print("SearchPage : submit keyword : $value");

         },
       ),
     ),
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
    print("HomePasge : initState");
    // TODO: implement initState
    super.initState();
    _homeBloc = context.read();
    _homeBloc.eventSink.add(LoadTrendingMusicSliderEvent());
    _homeBloc.eventSink.add(LoadCountryTracksEvent("VN", "vietnam music", VariableConstant.LAYOUT_COMPO_VN));
    _homeBloc.eventSink.add(LoadCountryTracksEvent("US", "vietnam music", VariableConstant.LAYOUT_COMPO_VN));
    _homeBloc.eventSink.add(LoadCountryTracksEvent("KR", "vietnam music", VariableConstant.LAYOUT_COMPO_VN));
    _homeBloc.eventSink.add(LoadCountryTracksEvent("UK", "vietnam music", VariableConstant.LAYOUT_COMPO_VN));
  }

  @override
  Widget build(BuildContext context) {
    print("HomePasge : build");
    double baseWidth = MediaQuery.of(context).size.width;
    double baseHeight = MediaQuery.of(context).size.height;
    return SafeArea(child: Container(
      width: baseWidth,
      height: baseHeight,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 10),
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            height: null,
            child: StreamBuilder<VideosResponse>(
              stream: _homeBloc.sliderStreamController.stream,
              builder: (context,snapshot){
              if(snapshot.hasError || snapshot.data == null){
                  if(_homeBloc.sliderVideos.length > 0){
                    _sliderTrendingWidget(_homeBloc.sliderVideos,baseWidth);
                  }else{
                    return Container();
                  }
                }
                return _sliderTrendingWidget(snapshot.data!.videos,baseWidth);
              },
            ),
          ), //slider
          Container(
            height: null,
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            child: StreamBuilder<VideosResponse>(
              stream: _homeBloc.usTracksStreamController.stream,
              builder: (context,snapshot){
               if(snapshot.hasError || snapshot.data == null){
                  if(_homeBloc.usTopTracksVideos.length > 0){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Top Track US", style: TextStyle(fontSize: 20, color: Colors.white),),
                        _horizontalListVideo(_homeBloc.usTopTracksVideos),
                      ],
                    );
                  }else{
                    return Container();
                  }
                }
                print("_horizontalListVideo has data");
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Top Track US", style: TextStyle(fontSize: 20, color: Colors.white),),
                    _horizontalListVideo(snapshot.data!.videos),
                  ],
                );
              },
            ),
          ), //us
          Container(
            width: baseWidth*0.8,
            height:null ,
            margin: EdgeInsets.symmetric(horizontal: 5),
            child:   StreamBuilder<VideosResponse>(
                stream: _homeBloc.ukTracksStreamController.stream,
                builder: (context, snapshot) {
                  if(snapshot.hasError || snapshot.data == null){
                    return Container();
                  }

                  return _gridListVideos(snapshot.data!);
                }
            ),
          ), //gridview
          Container(
            height: null,
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            child: StreamBuilder<VideosResponse>(
              stream: _homeBloc.vnTracksStreamController.stream,
              builder: (context,snapshot){
                if(snapshot.hasError || snapshot.data == null){
                  if(_homeBloc.vnTopTracksVideos.length > 0){
                   return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Top Track VN", style: TextStyle(fontSize: 20, color: Colors.white),),
                        _horizontalListVideo(_homeBloc.vnTopTracksVideos),
                      ],
                    );
                  }else{
                    return Container();
                  }
                }
                print("vnTracksStreamController has data");
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Top Track VN", style: TextStyle(fontSize: 20, color: Colors.white),),
                    _horizontalListVideo(snapshot.data!.videos),
                  ],
                );
              },
            ),
          ),  //vn
          Container(
            height: null,
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            child: StreamBuilder<VideosResponse>(
              stream: _homeBloc.kpopTracksStreamController.stream,
              builder: (context,snapshot){
              if(snapshot.hasError || snapshot.data == null){
                  if(_homeBloc.kpopTopTracksVideos.length> 0){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Top Track Korea",style: TextStyle(fontSize: 20,color: Colors.white),),
                        _horizontalListVideo(_homeBloc.kpopTopTracksVideos),
                      ],
                    );
                  }else{
                    return Container();
                  }
                }
                print("kpopTracksStreamController has data");
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Top Track Korea",style: TextStyle(fontSize: 20,color: Colors.white),),
                    _horizontalListVideo(snapshot.data!.videos),
                  ],
                );
              },
            ),
          ),  //kpop
        ],

      ),
    ));
  }

  Widget _sliderTrendingWidget(List<Video> videos, double width){
    return Container(
      height: null,
      child: Align(
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
      ),
    );
  }

  Widget _sliderItem(Video video,double width){
    return Container(
      width: width,
      height: null,
      margin: EdgeInsets.symmetric(horizontal: 2.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(video.thumbnailUrl),
        ),
      ),
      child: Container(
        height: null,
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
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );

  }

  Widget _horizontalListVideo(List<Video> videos){
    return Container(
      height: 150,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: videos.length,
          itemExtent: null,
          itemBuilder: (context,index){
            return SquareWidget(videos[index]);
          }),
    );
  }

  Widget _gridListVideos(VideosResponse data){
    int itemCount = data.videos.length; // Tổng số lượng item
    int crossAxisCount = 2; // Số lượng item trên một hàng
    int rows = (itemCount / crossAxisCount).ceil(); // Số lượng hàng

    double itemHeight = 80.0; // Chiều cao của mỗi item

    double height = rows * itemHeight - 15; // Chiều cao của gridview

    return  Container(
      height: null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(data.nameLayout, style: TextStyle(fontSize: 20, color: Colors.white),),
          Container(
            height: height,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.only(bottom: 15),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              children: List.generate(
                data.videos.length,
                    (index) => Container(
                  height: null,
                  child: Center(
                    child: GridItemWidget(data.videos[index]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

