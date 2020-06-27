import 'package:flutter/material.dart';

// Models
import 'package:decker/models/Carta.dart';

// Styling
import 'package:decker/theme.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';

// Widgets
import 'package:decker/widgets/LoadingIndicator.dart';


class SearchComponent extends StatefulWidget {
  final bool loading;
  final bool gridEnabled;
  final bool editing;
  final List<Carta> cards;
  final List types;
  final List frecuencies;
  final void Function() openFilters;
  final void Function(String) queryCallBack;

  SearchComponent({
    this.cards, 
    this.types,
    this.frecuencies,
    this.loading,
    this.editing,
    this.gridEnabled,
    this.openFilters,
    this.queryCallBack
  });

  @override
  _SearchComponentState createState() => new _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  String query = "";
  bool showGrid = false;
  Carta selectedCard;
  bool showSelectedCard = false;
  int showTextCard = 0;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return widget.loading
          ? Center(
            child: loadingIndicator(size)
          )
          : body(size, constraints);
        },
      )
    );
  }

  Widget body(Size size, BoxConstraints constraints) {
    return showSelectedCard
    ? fullCard(size)
    : Column(
      children: <Widget>[
        SizedBox(height: size.width * 0.02),
        Row(
          children: <Widget>[
            textInput(context),
            SizedBox(width: 8),
            filterButton(context)
          ],
        ),
        widget.gridEnabled ? gridOption() : SizedBox(height: 50),
        Expanded(
          child: this.showGrid ? cardGrid(size) : cardList(size)
        ),
        Container(
          // Constrains causing a bug
          height: 56 + (size.width * 0.098) - ((size.height - constraints.maxHeight)/2)
        )
      ],
    );
  }

  Widget textInput(BuildContext context) {
    return Expanded(
      child: Stack(
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
          // this.query.length != 0
          // ? Positioned(
          //   right: 0,
          //   child: Padding(
          //     padding: EdgeInsets.only(right: 12.0),
          //     child: GestureDetector(
          //       onTap: () {
          //         setState(() {
          //           this.query = "";
          //         });
          //       },
          //       child: Container(
          //         height: 32,
          //         width: 16,
          //         child: Center(
          //           child: Icon(
          //             Boxicons.bxsXCircle,
          //             size: 16,
          //             color: ThemeColors.gray[300],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // )
          // : Container()
        ],
      )
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
        widget.queryCallBack(this.query);
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

  Widget filterButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.openFilters();
      },
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: ThemeColors.gray[700],
          borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            child: Text(
              "Filtros",
              style: TextStyle(
                letterSpacing: 0.2,
                color: ThemeColors.gray[200]
              ),
            ),
          ),
        ),
      ),
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

  Widget cardGrid(Size size) {
    List<Widget> gridItems = [];

    if (widget.cards != null) {
      for (var i = 0; i < widget.cards.length; i+=2) {
        gridItems.add(
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                gridItem(size, widget.cards[i]),
                widget.cards.length > i+1
                ? gridItem(size, widget.cards[i+1])
                : Container()
              ],
            ),
          )
        );
      }
    }
    return ListView(
      children: gridItems
    );
  }

  Widget gridItem(Size size, Carta card) {
    return GestureDetector(
      onTap: () {
        setState(() {
          this.selectedCard = card;
          this.showSelectedCard = true;
        });
      },
      child: Container(
        width: size.width * 0.44,
        height: (size.width * 0.44) * 1.43,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(card.pathImage))
        ),
      ),
    );
  }

  Widget cardList(Size size) {
    List<Widget> listItems = [];
    if (widget.cards != null) {
      for (var i = 0; i < widget.cards.length; i++) {
        listItems.add(
          listItem(size, widget.cards[i])
        );
      }
    }
    return ListView(children: listItems);
  }

  Widget listItem(Size size, Carta card) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: <Widget>[
          listItemTopSection(size, card),
          this.showTextCard == card.id
          ? listItemBottomSection(card)
          : Container(),
        ],
      ),
    );
  }

  Widget listItemTopSection(Size size, Carta card) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (this.showTextCard == card.id) {
            this.showTextCard = 0;
          }
          else {
            this.showTextCard = card.id;
          }
        });
      },
      child: Stack(
        children: <Widget>[
          topSectionBackgroundImage(size, card),
          topSectionGradient(size),
          card.coste != null
          ? topSectionNumbers(card)
          : Container(),
          topSectionText(size, card)
        ],
      ),
    );
  }

  Widget topSectionBackgroundImage(Size size, Carta card) {
    return Container(
      height: 100,
      width: size.width - 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2)),
        image: DecorationImage(
          image: NetworkImage(card.pathImage),
          fit: BoxFit.cover
        )
      ),
    );
  }

  Widget topSectionGradient(Size size) {
    return Container(
      height: 100,
      width: size.width - 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2)),
        gradient: LinearGradient(
          colors: [ThemeColors.black, Colors.transparent]
        ),
      ),
    );
  }

  Widget topSectionNumbers(Carta card) {
    return Positioned(
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: ThemeColors.black.withOpacity(0.8),
          borderRadius: BorderRadius.horizontal(right: Radius.circular(2))
        ),
        height: 100,
        width: 32,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                card.fuerza != null ? card.fuerza.toString() : "",
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.2,
                  color: ThemeColors.gray[100],
                  fontFamily: "SF Pro Text Bold",
                  fontWeight: FontWeight.w700
                ),
              ),
              Text(
                card.coste.toString(),
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.2,
                  color: ThemeColors.gray[100],
                  fontFamily: "SF Pro Text Bold",
                  fontWeight: FontWeight.w700
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget topSectionText(Size size, Carta card) {
    return Container(
      height: 100,
      width: size.width - 16,
      child: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              card.nombre,
              style: TextStyle(
                color: ThemeColors.gray[100],
                fontSize: 20,
                letterSpacing: 0.2,
                fontWeight: FontWeight.w700,
                fontFamily: "SF Pro Text Bold",
                height: 1.2
              ),
            ),
            Text(
              widget.types[card.tipoCarta]['nombre'],
              style: TextStyle(
                color: ThemeColors.gray[100],
                fontSize: 14,
                letterSpacing: 0.2,
                fontWeight: FontWeight.w300,
                fontFamily: "SF Pro Text Light",
                height: 1.428
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.frecuencies[card.frecuencia]['nombre'],
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
    );
  }

  Widget listItemBottomSection(Carta card) {
    return Container(
      color: ThemeColors.gray[700],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16,12,16,12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              card.getAttributesAsString(),
              style: TextStyle(
                color: ThemeColors.gray[100],
                fontWeight: FontWeight.w600,
                fontSize: 12,
                letterSpacing: 0.2,
              ),
            ),
            SizedBox(height: 8),
            Text(
              card.habilidad,
              style: TextStyle(
                color: ThemeColors.gray[100],
                fontFamily: "SF Pro Text Light",
                fontWeight: FontWeight.w300,
                fontSize: 12,
                letterSpacing: 0.2,
              ),
            ),
            widget.editing
            ? bottomSectionEditingButtons()
            : bottomSectionImageButton(card)
          ],
        ),
      ),
    );
  }

  Widget bottomSectionEditingButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              // Add to sidedeck callback
            },
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: ThemeColors.gray[500],
                borderRadius: BorderRadius.all(Radius.circular(2))
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Banquillo",
                    style: TextStyle(
                      color: ThemeColors.gray[200],
                      fontSize: 12,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            )
          ),
          SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              // Add to maindeck callback
            },
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: ThemeColors.gray[400],
                borderRadius: BorderRadius.all(Radius.circular(2))
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Mazo principal",
                    style: TextStyle(
                      color: ThemeColors.gray[100],
                      fontSize: 12,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }

  Widget bottomSectionImageButton(Carta card) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                this.selectedCard = card;
                this.showSelectedCard = true;
              });
            },
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: ThemeColors.gray[500],
                borderRadius: BorderRadius.all(Radius.circular(2))
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Ver imagen",
                    style: TextStyle(
                      color: ThemeColors.gray[200],
                      fontSize: 12,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }

  Widget fullCard(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              this.showSelectedCard = false;
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
          child: Center(
            child: Container(
              width: size.width - 16,
              height: (size.width - 16) * 1.43,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(this.selectedCard.pathImage)
                )
              ),
            ),
          )
        ),
        SizedBox(height: 64)
      ],
    );
  }
}