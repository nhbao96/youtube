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
        icon: Icon(Icons.home,color: Colors.deepOrange,),
        label:"Home" ,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search,color: Colors.deepOrange),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person,color: Colors.deepOrange),
        label: 'Profile',
      ),
    ];

    _currentIndex = widget.indexSelectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      items: _bottomNavBarItems,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      // Đặt style cho label của các BottomNavigationBarItem
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal,color: Colors.grey),
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
        Navigator.pushReplacementNamed(context, "home-page");
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
