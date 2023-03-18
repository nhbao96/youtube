import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/navigation_bar/navigation_bar.dart';

class PageContainer extends StatelessWidget {
  final Widget child;
  final List<SingleChildWidget> providers;
  AppBar? appBar;
  bool? isShowNavigationBar;
  int? indexSelectedNavigation;

  PageContainer(
      {required this.child,
      required this.providers,
      this.appBar,
      this.isShowNavigationBar,
      this.indexSelectedNavigation});

  @override
  Widget build(BuildContext context) {
    return shouldRenderPage();
  }

  Widget shouldRenderPage() {
    if (this.isShowNavigationBar == true) {
      if (providers.isNotEmpty) {
        return MultiProvider(
          providers: [...providers],
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: appBar,
            body: child,
            bottomNavigationBar:
            NavigationBarBottom(indexSelectedNavigation ?? 0),
          ),
        );
      } else {
        return Scaffold(
            backgroundColor: Colors.black,
            appBar: appBar,
            body: child,
            bottomNavigationBar:
            NavigationBarBottom(indexSelectedNavigation ?? 0));
      }
    } else {
      if (providers.isNotEmpty) {
        return MultiProvider(
          providers: [...providers],
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: appBar,
            body: child,
          ),
        );
      } else {
        return Scaffold(
          backgroundColor: Colors.black,
            appBar: appBar,
            body: child,);
      }
    }
  }
}
