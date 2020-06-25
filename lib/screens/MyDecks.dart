import 'package:flutter/material.dart';

// Authentication
import 'package:decker/globals.dart';

// Models
import 'package:decker/models/Mazo.dart';
import 'package:decker/models/Carta.dart';

// Components
import 'package:decker/components/NoLoggedComponent.dart';

// Widgets
import 'package:decker/widgets/LoadingIndicator.dart';

// Styling
import 'package:decker/theme.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';

// Search
import 'package:diacritic/diacritic.dart';


class MyDecks extends StatefulWidget {
  final List<Mazo> deckList;
  final List<Carta> cardList;
  final bool loading;

  MyDecks({
    this.deckList,
    this.cardList,
    this.loading
  });

  @override
  _MyDecksState createState() => new _MyDecksState();
}

class _MyDecksState extends State<MyDecks> {
  List<Mazo> filteredDecks;
  String query;
  Mazo selectedDeck;
  bool showDeck = false;

  String sortBy = "Orden por defecto";
  List<String> sortOptions = [
    "Orden por defecto",
    "Alfabéticamente A-Z",
    "Alfabéticamente Z-A",
  ];

  void initState() {
    this.filteredDecks = widget.deckList;
    super.initState();
  }

  void handleLoginCallback() {

  }

  void handleRegisterCallback() {

  }

  void updateListFromQuery() {
    List<Mazo> updatedList = [];
    String buffer = removeDiacritics(this.query.trim().toLowerCase());
    widget.deckList.forEach((deck) {
      if (deck.nombre.contains(buffer)) {
        updatedList.add(deck);
      }
    });
    setState(() {
      this.filteredDecks = updatedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return !isAuthenticated
          ? NoLoggedComponent(
            message: "crear mazos",
            loginCallback: handleLoginCallback,
            registerCallback: handleRegisterCallback,
          )
          : body(size, constraints);
        }
      ),
    );
  }

  Widget body(Size size, BoxConstraints constraints) {
    return widget.loading
    ? loadingIndicator(size)
    : Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(height: size.width * 0.02),
        textInput(context),
        sortOption(),
        Expanded(
          child: myDeckList(size)
        ),
        Container(
          height: 56 + (size.width * 0.098) - ((size.height - constraints.maxHeight)/2)
        )
      ]
    );
  }

  Widget textInput(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 32,
          decoration: BoxDecoration(
            color: ThemeColors.gray[500],
            borderRadius: BorderRadius.all(Radius.circular(4))
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 16,
                child: Container(
                  height: 32,
                  child: Icon(
                    FeatherIcons.search,
                    size: 16,
                    color: ThemeColors.gray[300],
                  )
                )
              ),
              Center(
                child: textField(context)
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget textField(BuildContext context) {
    return TextFormField(
      onChanged: (newQuery) {
        setState(() {
          this.query = newQuery;
        });
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(FocusNode());
        this.updateListFromQuery();
      },
      initialValue: this.query,
      cursorColor: ThemeColors.gray[200],
      style: TextStyle(
        fontSize: 14,
        letterSpacing: 0.2,
        color: ThemeColors.gray[100]
      ),
      decoration: InputDecoration(
        isDense: true,
        border: InputBorder.none,
        contentPadding: EdgeInsets.fromLTRB(44,0,42,0),
        hintText: "Buscar",
        hintStyle: TextStyle(
          letterSpacing: 0.2,
          color: ThemeColors.gray[300]
        )
      ),
    );
  }

  Widget sortOption() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0,15,0,30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isDense: true,
                    dropdownColor: ThemeColors.gray[600],
                    value: this.sortBy,
                    icon: Icon(FeatherIcons.chevronDown, color: ThemeColors.gray[400]),
                    onChanged: (newValue) {
                      setState(() {
                        this.sortBy = newValue;
                      });
                    },
                    items: this.sortOptions.map((val) {
                      return DropdownMenuItem(
                        key: Key(val),
                        value: val,
                        child: Text(
                          val,
                          style: TextStyle(
                            letterSpacing: 0.2,
                            color: ThemeColors.gray[200],
                            fontSize: 14
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget myDeckList(Size size) {
    List<Widget> listItems = [];
    if (this.filteredDecks != null) {
      for (var i = 0; i < this.filteredDecks.length; i++) {
        listItems.add(
          listItem(size, this.filteredDecks[i])
        );
      }
    }
    return ListView(children: listItems);
  }

  Widget listItem(Size size, Mazo deck) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          setState(() {
            this.selectedDeck = deck;
            this.showDeck = true;
          });
        },
        child: Stack(
          children: <Widget>[
            Container(
              height: 100,
              width: size.width - 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                image: DecorationImage(
                  image: NetworkImage(widget.cardList[deck.main[0]['id'] - 1].pathImage),
                  fit: BoxFit.cover
                )
              ),
            ),
            Container(
              height: 100,
              width: size.width - 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                gradient: LinearGradient(
                  colors: [ThemeColors.black, Colors.transparent]
                ),
              ),
            ),
            Container(
              height: 100,
              width: size.width - 16,
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      deck.nombre,
                      style: TextStyle(
                        color: ThemeColors.gray[100],
                        fontSize: 20,
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.w700,
                        fontFamily: "SF Pro Text Bold",
                        height: 1.2
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      deck.formato,
                      style: TextStyle(
                        color: ThemeColors.gray[100],
                        fontSize: 14,
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                        fontFamily: "SF Pro Text Light",
                        height: 1.428
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}