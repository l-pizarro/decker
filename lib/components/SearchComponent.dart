import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

// Models
import 'package:decker/models/Carta.dart';

// Styling
import 'package:decker/theme.dart';

class SearchComponent extends StatefulWidget {
  final bool loading;
  final bool gridEnabled;
  final bool editing;
  final List<Carta> cards;
  final List types;
  final List frecuencies;

  SearchComponent({
    this.cards,
    this.types,
    this.frecuencies,
    this.loading,
    this.editing,
    this.gridEnabled
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
  List<Carta> results;

  void initState() {
    setState(() {
      this.results = widget.cards;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return showSelectedCard 
    ? fullCard(size)
    : Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            textInput(),
            SizedBox(width: 8),
            filterButton()
          ],
        ),
        widget.gridEnabled ? gridOption() : SizedBox(height: 50),
        Expanded(
          child: this.showGrid ? cardGrid(size) : cardList(size)
        ),
        SizedBox(height: 64)
      ],
    );
  }

  Widget textInput() {
    return Expanded(
      child: Container(
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
              child: textField()
            ),
          ],
        ),

      )
    );
  }

  Widget textField() {
    return TextField(
      cursorColor: ThemeColors.gray[200],
      style: TextStyle(
        fontSize: 14,
        color: ThemeColors.gray[100]
      ),
      decoration: InputDecoration(
        isDense: true,
        border: InputBorder.none,
        contentPadding: EdgeInsets.fromLTRB(44,0,8,0),
        hintText: "Buscar",
        hintStyle: TextStyle(
          color: ThemeColors.gray[300]
        )
      ),
    );
  }

  Widget filterButton() {
    return GestureDetector(
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

    if (this.results != null) {
      for (var i = 0; i < this.results.length; i+=2) {
        gridItems.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      this.selectedCard = this.results[i];
                      this.showSelectedCard = true;
                    });
                  },
                  child: Container(
                    width: size.width * 0.44,
                    height: (size.width * 0.44) * 1.43,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(this.results[i].pathImage))
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      this.selectedCard = this.results[i+1];
                      this.showSelectedCard = true;
                    });
                  },
                  child: Container(
                    width: size.width * 0.44,
                    height: (size.width * 0.44) * 1.43,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(this.results[i+1].pathImage))
                    ),
                  ),
                ),
              ],
            ),
          )
        );
      }
    }
    return ListView(
      children: gridItems,
    );
  }

  Widget cardList(Size size) {
    List<Widget> listItems = [];
    if (this.results != null) {
      for (var i = 0; i < this.results.length; i++) {
        listItems.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (this.showTextCard == this.results[i].id) {
                        this.showTextCard = 0;
                      }
                      else {
                        this.showTextCard = this.results[i].id;
                      }
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
                            image: NetworkImage(this.results[i].pathImage),
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
                      this.results[i].coste != null ? Positioned(
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
                                  this.results[i].fuerza != null ? this.results[i].fuerza.toString() : "",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: ThemeColors.gray[100],
                                    fontFamily: "SF Pro Text Bold",
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                  this.results[i].coste.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: ThemeColors.gray[100],
                                    fontFamily: "SF Pro Text Bold",
                                    fontWeight: FontWeight.w700
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                      :Container(),
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
                                this.results[i].nombre,
                                style: TextStyle(
                                  color: ThemeColors.gray[100],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "SF Pro Text Bold",
                                  height: 1.2
                                ),
                              ),
                              Text(
                                widget.types[this.results[i].tipoCarta]['nombre'],
                                style: TextStyle(
                                  color: ThemeColors.gray[100],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "SF Pro Text Light",
                                  height: 1.428
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                widget.frecuencies[this.results[i].frecuencia]['nombre'],
                                style: TextStyle(
                                  color: ThemeColors.gray[100],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: "SF Pro Text Light",
                                  height: 1.428
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                this.showTextCard == this.results[i].id
                ? Container(
                  color: ThemeColors.gray[700],
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16,12,16,12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          this.results[i].getAttributesAsString(),
                          style: TextStyle(
                            color: ThemeColors.gray[100],
                            fontWeight: FontWeight.w600,
                            fontSize: 12
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          this.results[i].habilidad,
                          style: TextStyle(
                            color: ThemeColors.gray[100],
                            fontFamily: "SF Pro Text Light",
                            fontWeight: FontWeight.w300,
                            fontSize: 12
                          ),
                        ),
                        widget.editing
                        ? Padding(
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
                                          fontSize: 12
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
                                          fontSize: 12
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              )
                            ],
                          ),
                        )
                        : Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    this.selectedCard = this.results[i];
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
                                          fontSize: 12
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
                : Container()
              ],
            ),
          ),
        );
      }
    }

    return ListView(
      children: listItems,
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
                          fontSize: 16
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