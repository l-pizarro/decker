import 'package:flutter/material.dart';
import 'package:decker/components/PageContainer.dart';
import 'package:decker/components/BottomNav.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => new _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedPage = 0;

  void initState() {
    super.initState();
  }

  void handleBottomNavClick(int selectedPage) {
    setState(() {
      _selectedPage = selectedPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageContainer(size: size, selectedPage: _selectedPage),
          BottomNav(size: size, selectedPage: _selectedPage, onBottomNavClick: handleBottomNavClick,)
        ],
      ),
    );
  }
}