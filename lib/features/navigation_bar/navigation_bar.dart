import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationBarBottom extends StatefulWidget {

  int indexSelectedItem;

  NavigationBarBottom(this.indexSelectedItem);

  @override
  State<NavigationBarBottom> createState() => _NavigationBarBottomState();
}

class _NavigationBarBottomState extends State<NavigationBarBottom> {
  late List<BottomNavigationBarItem> _bottomNavBarItems;
  late int _currentIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bottomNavBarItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ];

    _currentIndex = widget.indexSelectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _bottomNavBarItems,
      currentIndex: _currentIndex,
      onTap: (index) {
        _onTap(index);
      },
    );
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch(index) {
      case 0:
      // navigate to home page
        Navigator.pushReplacementNamed(context, "home-screen");
        break;
      case 1:
      // navigate to search page
        Navigator.pushReplacementNamed(context, "search-page");
        break;
      case 2:
      // navigate to profile page
        break;
      default:
      // do nothing
        break;
    }
  }
}
