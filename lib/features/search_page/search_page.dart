import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_baonh/common/bases/base_widget.dart';
import 'package:youtube_baonh/data/datasources/models/search_model.dart';
import 'package:youtube_baonh/data/datasources/models/video_model.dart';
import 'package:youtube_baonh/data/respositories/search_respository.dart';
import 'package:youtube_baonh/data/services/api_service.dart';
import 'package:youtube_baonh/features/search_page/search_bloc.dart';
import 'package:youtube_baonh/features/search_page/search_events.dart';

import '../components/components.dart';
import '../player_page/video_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: SearchContainer(),
      providers: [
        Provider<APIService>(create: (context) => APIService()),
        ProxyProvider<APIService, SearchRespository>(
            create: (context) => SearchRespository(),
            update: (context, apiService, searchRespository) {
              searchRespository?.updateAPIService(apiService);
              return searchRespository!;
            }),
        ProxyProvider<SearchRespository, SearchBloc>(
            create: (context)=>SearchBloc(),
            update: (context, searchRespository, searchBloc){
              searchBloc?.updateSearchRespository(searchRespository);
              return searchBloc!;
            })
      ],
      isShowNavigationBar: true,
      indexSelectedNavigation: 1,
    );
  }
}

class SearchContainer extends StatefulWidget {
  const SearchContainer({Key? key}) : super(key: key);

  @override
  State<SearchContainer> createState() => _SearchContainerState();
}

class _SearchContainerState extends State<SearchContainer> {
  late SearchBloc _searchBloc;
  final _searchController = TextEditingController();
  late bool _isShowRecommendKeywords;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchBloc = context.read();
    _searchBloc.eventSink.add(LoadRecommendKeywords());
    _isShowRecommendKeywords = true;
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tìm kiếm",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Bạn muốn nghe gì?",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white
                ),
                onChanged: (value){
                  _searchBloc.eventSink.add(AutoCompleteKeywordsEvent(value));
                },
                onSubmitted: (value){
                  print("SearchPage : submit keyword : $value");
                  _searchBloc.eventSink.add(SearchWithKeywordEvent(value));
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Nội dung tìm kiếm",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,color: Colors.white
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<SearchModel>(
                stream: _searchBloc.streamController.stream,
                builder: (context, snapshot) {
                  if(snapshot.hasError || snapshot.data == null){
                    return Container();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.videos.length,
                    itemBuilder: (context, index) {
                      if(snapshot.data!.typeDisplay == 0){
                        final keyword = snapshot.data!.videos[index].title;
                        print("SearchPage : keyword : $keyword");
                        return keywordWidget(snapshot.data!.videos[index]);
                      }else{
                        return buildVideo(context,snapshot.data!.videos[index]);
                      }
                    },
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget keywordWidget(Video video){
    return ListTile(
      title: Text(video.title,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),),
      onTap: () {
        // Set the search keyword from the recommended list
        _searchController.text = video.title;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoScreenPage(video),
          ),
        );
      },
    );
 }

}
