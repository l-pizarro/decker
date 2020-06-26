import 'package:flutter/material.dart';

// Components
import 'package:decker/components/SearchComponent.dart';

// Models
import 'package:decker/models/Carta.dart';
import 'package:decker/models/Mazo.dart';

// Widgets
import 'package:decker/widgets/PageContainer.dart';
import 'package:decker/widgets/BottomNav.dart';

// Screens
import 'package:decker/screens/MyDecks.dart';

// Database
import 'package:decker/db.dart';

// Styling
import 'package:decker/theme.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';

// Search
import 'package:diacritic/diacritic.dart';


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
  List<Carta> queryCards = List<Carta>();
  List<Mazo> userDecks;
  List cardTypes = [];
  List cardFrecuencies = [];
  List cardEditions = [];

  // Filters
  List<String> dropdownSelections = [null, null, null];

  // Query
  String query = "";

  GlobalKey<ScaffoldState> _mainViewKey = GlobalKey();

  void initState() {
    super.initState();
    this.getCards();
  }

  void getCards() {
    setState(() {
      this.cardList = DB.getCartas();
      this.filteredCards = this.cardList;
      this.queryCards = this.filteredCards;
      this.cardTypes = DB.getTipoCartas();
      this.cardFrecuencies = DB.getFrecuencias();
      this.cardEditions = DB.getEdiciones();
      this.userDecks = DB.getMazos();
      this.cardLoading = false;
    });
  }

  void updateListFromQuery(String query) {
    setState(() {
      this.query = query; 
    });
    List<Carta> updatedList = [];
    String buffer = removeDiacritics(query.trim().toLowerCase());
    this.filteredCards.forEach((card) {
      String cardText = removeDiacritics(card.getAllText());
      if (cardText.contains(buffer)) {
        updatedList.add(card);
      }
    });
    setState(() {
      this.queryCards = updatedList;
    });
  }

  void applyFilters() {
    if (dropdownSelections[0] != null) this.filterByEdition();
    if (dropdownSelections[1] != null) this.filterByType();
    if (dropdownSelections[2] != null) this.filterByFrecuency();
  }

  void cleanFilters() {
    setState(() {
      this.dropdownSelections = dropdownSelections = [null, null, null];
      this.filteredCards = this.cardList;
      updateListFromQuery(this.query); 
    });
  }

  void filterByEdition() {
    List<Carta> filtered = [];
    this.cardList.forEach((card) {
      if (this.cardEditions[card.edicion]['nombre'] == this.dropdownSelections[0]) {
        filtered.add(card);
      }
    });
    setState(() {
      this.filteredCards = filtered;
    });
  }

  void filterByType() {
    List<Carta> filtered = [];
    this.filteredCards.forEach((card) {
      if (this.cardTypes[card.tipoCarta]['nombre'] == this.dropdownSelections[1]) {
        filtered.add(card);
      }
    });
    setState(() {
      this.filteredCards = filtered;
    });
  }

  void filterByFrecuency() {
    List<Carta> filtered = [];
    this.filteredCards.forEach((card) {
      if (this.cardFrecuencies[card.frecuencia]['nombre'] == this.dropdownSelections[2]) {
        filtered.add(card);
      }
    });
    setState(() {
      this.filteredCards = filtered;
    });
    updateListFromQuery(this.query);
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
        cards: queryCards,
        types: cardTypes,
        frecuencies: cardFrecuencies,
        gridEnabled: true,
        editing: false,
        openFilters: () {
          _mainViewKey.currentState.openEndDrawer();
        },
        queryCallBack: this.updateListFromQuery,
      ),
      MyDecks(
        deckList: userDecks,
        cardList: cardList,
        loading: cardLoading
      ),
      Column(children: <Widget>[Text("Crear mazo")]),
      Column(children: <Widget>[Text("Favoritos")]),
      Column(children: <Widget>[Text("Mi perfil")]),
    ];
    return Scaffold(
      key: _mainViewKey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          PageContainer(size: size, selectedPage: _selectedPage, pages: pages),
          BottomNav(size: size, selectedPage: _selectedPage, onBottomNavClick: handleBottomNavClick)
        ],
      ),
      endDrawer: drawer(size),
      drawerEdgeDragWidth: _selectedPage == 0 ? size.width * 0.05 : 0
    );
  }

  Widget drawer(Size size) {
    return Drawer(
      child: Container(
        color: ThemeColors.gray[600],
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.08,
              vertical: size.width * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Filtros",
                  style: TextStyle(
                    fontFamily: "SF Pro Text Bold",
                    fontWeight: FontWeight.w600,
                    color: ThemeColors.gray[200],
                    fontSize: 20,
                    letterSpacing: 0.2
                  ),
                ),
                SizedBox(height: 64),
                dropDown(0, this.cardEditions, "Edición", 'Seleccione una edición'),
                SizedBox(height: 40),
                dropDown(1, this.cardTypes, "Tipo", 'Seleccione un tipo'),
                SizedBox(height: 40),
                dropDown(2, this.cardFrecuencies, "Frecuencia", 'Seleccione una frecuencia'),
                SizedBox(height: 64),
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: double.infinity),
                  child: RaisedButton(
                    color: ThemeColors.gray[400],
                    onPressed: () {
                      this.applyFilters();
                    },
                    child: Text(
                      "Aplicar",
                      style: TextStyle(
                        color: ThemeColors.gray[100],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        this.cleanFilters();
                      },
                      child: Container(
                        child: Text(
                          "Limpiar",
                          style: TextStyle(
                            color: ThemeColors.gray[200],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dropDown(index, List list, String label, String hint) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: ThemeColors.gray[200].withOpacity(0.6),
              fontFamily: "SF Pro Text Bold",
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 0.2
            ),
          ),
          SizedBox(height: 12),
          Container(
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isDense: true,
                dropdownColor: ThemeColors.gray[600],
                value: this.dropdownSelections[index],
                icon: Icon(FeatherIcons.chevronDown, color: ThemeColors.gray[400]),
                isExpanded: true,
                hint: Text(
                  hint,
                  style: TextStyle(
                    letterSpacing: 0.2,
                    color: Colors.grey[600],
                    fontSize: 14
                  )
                ),
                onChanged: (newValue) {
                  setState(() {
                    this.dropdownSelections[index] = newValue;
                    print(this.dropdownSelections[index]);
                  });
                },
                items: list.map((val) {
                  return DropdownMenuItem(
                    key: Key(val['nombre']),
                    value: val['nombre'],
                    child: Text(
                      val['nombre'],
                      style: TextStyle(
                        letterSpacing: 0.2,
                        color: ThemeColors.gray[100],
                        fontSize: 14
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            height: 1,
            color: ThemeColors.gray[400],
          )
        ],
      ),
    );
  }
}