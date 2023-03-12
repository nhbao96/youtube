import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_baonh/common/bases/base_widget.dart';
import 'package:youtube_baonh/data/datasources/models/video_model.dart';
import 'package:youtube_baonh/data/respositories/search_respository.dart';
import 'package:youtube_baonh/data/services/api_service.dart';
import 'package:youtube_baonh/features/search_page/search_bloc.dart';
import 'package:youtube_baonh/features/search_page/search_events.dart';

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
  final List<String> _recommendedKeywords = [
    "Flutter",
    "Dart",
    "Mobile Development",
    "UI Design",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchBloc = context.read();
    _searchBloc.eventSink.add(LoadRecommendKeywords());
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search...",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Recommended keywords",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<List<Video>>(
                stream: _searchBloc.streamController.stream,
                builder: (context, snapshot) {
                  if(snapshot.hasError || snapshot.data == null){
                    return Container();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final keyword = snapshot.data![index].title;
                      print("SearchPage : keyword : $keyword");
                      return ListTile(
                        title: Text(keyword),
                        onTap: () {
                          // Set the search keyword from the recommended list
                          _searchController.text = keyword;
                        },
                      );
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



}
