import 'package:decker/components/SearchComponent.dart';
import 'package:flutter/material.dart';

// Styling
// import 'package:decker/theme.dart';
// import 'package:feather_icons_flutter/feather_icons_flutter.dart';
// import 'package:boxicons_flutter/boxicons_flutter.dart';

// Models
import 'package:decker/models/Carta.dart';


class Explore extends StatefulWidget {
  final List<Carta> cards;
  final bool loading;
  final void Function() onExploreClick;

  Explore({
    this.cards,
    this.loading,
    this.onExploreClick
  });

  @override
  _ExploreState createState() => new _ExploreState();
}

class _ExploreState extends State<Explore> {

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SearchComponent(loading: widget.loading);
  }
}