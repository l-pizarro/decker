import 'package:decker/components/SearchComponent.dart';
import 'package:flutter/material.dart';

// Models
import 'package:decker/models/Carta.dart';

// Screens
import 'package:decker/screens/Explore.dart';

// Widgets
import 'package:decker/widgets/PageContainer.dart';
import 'package:decker/widgets/BottomNav.dart';

// Database
import 'package:decker/db.dart';


class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => new _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedPage = 0;

  // Cards
  bool cardLoading = true;
  List<Carta> cardList = List<Carta>();
  List<Carta> filteredCards = List<Carta>();
  List cardTypes = [];
  List cardFrecuencies = [];

  void initState() {
    super.initState();
    this.getCards();
  }

  void getCards() {
    setState(() {
      this.cardList = DB.getCartas();
      this.filteredCards = this.cardList;
      this.cardTypes = DB.getTipoCartas();
      this.cardFrecuencies = DB.getFrecuencias();
      print(this.cardFrecuencies);
      this.cardLoading = true;
    });
  }

  void handleExploreClick() {
    setState(() {
      cardLoading = !cardLoading;
    });
  }

  void handleBottomNavClick(int selectedPage) {
    setState(() {
      _selectedPage = selectedPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> pages = [
      SearchComponent(
        loading: cardLoading,
        cards: filteredCards,
        types: cardTypes,
        frecuencies: cardFrecuencies,
        gridEnabled: true,
        editing: false,
      ),
      Column(children: <Widget>[Text("1")]),
      Column(children: <Widget>[Text("2")]),
      Column(children: <Widget>[Text("3")]),
      Column(children: <Widget>[Text("4")]),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          PageContainer(size: size, selectedPage: _selectedPage, pages: pages),
          BottomNav(size: size, selectedPage: _selectedPage, onBottomNavClick: handleBottomNavClick,)
        ],
      ),
    );
  }
}