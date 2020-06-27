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
  bool showGrid = false;

  String sortBy = "Más recientes primero";
  List<String> sortOptions = [
    "Más recientes primero",
    "Más antiguos primero",
    "Alfabéticamente A-Z",
    "Alfabéticamente Z-A",
  ];

  void initState() {
    this.filteredDecks = widget.deckList;
    filteredDecks.sort((a, b) => a.date.compareTo(b.date));
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

  void sortDecks() {
     if (sortBy == "Más recientes primero") {
      filteredDecks.sort((a, b) => a.date.compareTo(b.date));
    }
     if (sortBy == "Más antiguos primero") {
      filteredDecks.sort((a, b) => a.date.compareTo(b.date));
      setState(() {
        this.filteredDecks = this.filteredDecks.reversed.toList();
      });
    }
    if (sortBy == "Alfabéticamente A-Z") {
       filteredDecks.sort((a, b) => a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase()));
    }
    if (sortBy == "Alfabéticamente Z-A") {
      filteredDecks.sort((a, b) => a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase()));
      setState(() {
        this.filteredDecks = this.filteredDecks.reversed.toList();
      });
    }
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
    : showDeck
    ? deckDetail(size)
    : Column(
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
                      if (newValue != this.sortBy) {
                        setState(() {
                          this.sortBy = newValue;
                        });
                        this.sortDecks();
                      }
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
    Widget deckDetail(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              this.showDeck = false;
            });
          },
          child: Container(
            height: 20,
            child: Row(
              children: <Widget>[
                Icon(FeatherIcons.arrowLeft, size: 20, color: ThemeColors.gray[300]),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Container(
                    height: 20,
                    child: Center(
                      child: Text(
                        "Volver",
                        style: TextStyle(
                          color: ThemeColors.gray[300],
                          fontSize: 16,
                          letterSpacing: 0.2,
                        ),
                      )
                    )
                  ),
                )
              ],
            )
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 48),
              Text(
                selectedDeck.nombre,
                style: TextStyle(
                  color: ThemeColors.gray[100],
                  fontFamily: "SF Pro Text Regular",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2
                ),
              ),
              SizedBox(height: 12),
              Text(
                selectedDeck.formato,
                style: TextStyle(
                  color: ThemeColors.gray[200],
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0.2,
                  fontSize: 14
                ),
              ),
              SizedBox(height: 24),
              gridOption(),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    cardList(size, this.selectedDeck.main, "Mazo principal"),
                    SizedBox(height: 40),
                    cardList(size, this.selectedDeck.side, "Banquillo"),
                    SizedBox(height: 40),
                    monument(size)
                  ],
                )
              )
            ],
          )
        ),
        SizedBox(height: 64)
      ],
    );
  }

  Widget gridOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0,15,0,30),
          child: GestureDetector(
            onTap: () {
              setState(() {
                this.showGrid = !this.showGrid;
              });
            },
            child: Container(
              height: 24,
              width: 24,
              child: Icon(
                FeatherIcons.grid,
                color: this.showGrid ? ThemeColors.gray[100] : ThemeColors.gray[400],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget cardList(Size size, List<Map<String, int>> cardList, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label.toUpperCase(),
          style: TextStyle(
            letterSpacing: 0.2,
            color: ThemeColors.gray[300],
            fontSize: 12,
            fontFamily: "SF Pro Text Bold"
          ),
        ),
        SizedBox(height: 12),
        cardList.length == 0
        ? Text(
          "Sin cartas",
          style: TextStyle(
            color: ThemeColors.gray[400],
            fontStyle: FontStyle.italic,
            letterSpacing: 0.2
          ),
        )
        : Column(
          children: showGrid ? cardImages(cardList, size) : cardTexts(cardList, size),
        )
      ],
    );
  }

  List<Widget> cardImages(List<Map<String, int>> cards, Size size) {
    List<Widget> allImages = [];
    if (cardList != null) {
      for (var i = 0; i < cards.length; i++) {
        for (var j = 0; j < cards[i]['amount']; j++) {
          allImages.add(
            cardImage(size, widget.cardList[cards[i]['id'] - 1])
          );
        }
      }
    }
    List<Widget> cardImages = [];
    for (var i = 0; i < allImages.length; i+=3) {
      cardImages.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              allImages[i],
              allImages.length > i+1 ? allImages[i+1] : Container(width: (size.width - 64) / 3),
              allImages.length > i+2 ? allImages[i+2] : Container(width: (size.width - 64) / 3),
            ],
          ),
        )
      );
    }
    return cardImages;
  }

  Widget cardImage(Size size, Carta card) {
    return Container(
      width: (size.width - 64) / 3,
      height: (size.width - 64) * (1.43/3),
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(card.pathImage))
      ),
    );
  }



  List<Widget> cardTexts(List<Map<String, int>> cardList, Size size) {
    List<Widget> texts = [];
    if (cardList != null) {
      for (var i = 0; i < cardList.length; i++) {
        texts.add(
          Container(
            height: 32,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 24,
                  child: Text(
                    cardList[i]["amount"].toString(),
                    style: TextStyle(
                      color: ThemeColors.gray[100],
                      letterSpacing: 0.2
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.4,
                  child: Text(
                    widget.cardList[cardList[i]["id"] - 1].nombre,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ThemeColors.gray[100],
                      letterSpacing: 0.2
                    ),
                  ),
                )
              ],
            ),
          )
        );
      }
    }
    return texts;
  }

  Widget monument(Size size) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "MONUMENTO",
            style: TextStyle(
              letterSpacing: 0.2,
              color: ThemeColors.gray[300],
              fontSize: 12,
              fontFamily: "SF Pro Text Bold",
            ),
          ),
          SizedBox(height: 12),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                this.selectedDeck.monument == null
                ? Text(
                  "Sin monumento",
                  style: TextStyle(
                    color: ThemeColors.gray[400],
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.2
                  ),
                )
                : showGrid
                ? Container(
                  width: (size.width - 64) / 3,
                  height: (size.width - 64) * (1.43/3),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.cardList[selectedDeck.monument - 1].pathImage),
                    )
                  )
                )
                : Container(
                  child: Text(
                    widget.cardList[this.selectedDeck.monument-1].nombre,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ThemeColors.gray[100],
                      letterSpacing: 0.2
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}