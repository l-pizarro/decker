import 'package:flutter/material.dart';
import 'package:decker/theme.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:boxicons_flutter/boxicons_flutter.dart';


class BottomNav extends StatefulWidget {
  final Size size ;
  final int selectedPage;
  final void Function(int) onBottomNavClick;

  BottomNav({
    this.size,
    this.selectedPage,
    this.onBottomNavClick
  });

  @override
  _BottomNavState createState() => new _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  void initState() {
    super.initState();
  }

  List<Widget> navItems() {
    var icons = [
      Icon(FeatherIcons.search, color: ThemeColors.gray[100]),
      Icon(FeatherIcons.layers, color: ThemeColors.gray[100]),
      Icon(Icons.add, color: ThemeColors.gray[100]),
      Icon(Boxicons.bxHeart, color: ThemeColors.gray[100]),
      Icon(Boxicons.bxUser, color: ThemeColors.gray[100]),
    ];

    var labels = [
      "Explorar",
      "Mis mazos",
      "Crear mazo",
      "Favoritos",
      "Mi perfil",
    ];

    List<Widget> items = [];

    for (var i = 0; i < 5; i++) {
      items.add(
        GestureDetector(
          onTap: () {
            widget.onBottomNavClick(i);
          },
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: i == 2 ? 48 : 24,
                  height: 32,
                  decoration: BoxDecoration(
                    color: i == 2 ? ThemeColors.red : ThemeColors.black,
                    borderRadius: BorderRadius.all(Radius.circular(2))
                  ),
                  child: Opacity(
                    opacity: widget.selectedPage == i || i == 2 ? 1 : 0.5,
                    child: Center(child: icons[i])
                  )
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    labels[i],
                    style: TextStyle(
                      color: widget.selectedPage == i ? ThemeColors.gray[100] : ThemeColors.black,
                      fontSize: 11,
                      fontFamily: "Roboto"
                    ),
                  ),
                )
              ],
            ),
          )
        )
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: widget.size.width,
        height: 56 + (widget.size.width * 0.098),
        color: ThemeColors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: navItems()
          ),
        )
      )
    );
  }
}