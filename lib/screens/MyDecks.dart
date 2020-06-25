import 'package:flutter/material.dart';

// Models
// import 'package:decker/models/Carta.dart';

// Components
import 'package:decker/components/NoLoggedComponent.dart';

// Styling
// import 'package:decker/theme.dart';
// import 'package:feather_icons_flutter/feather_icons_flutter.dart';

// Authentication 
import 'package:decker/globals.dart';


class MyDecks extends StatefulWidget {

  MyDecks();

  @override
  _MyDecksState createState() => new _MyDecksState();
}

class _MyDecksState extends State<MyDecks> {

  void initState() {
    super.initState();
  }

  void handleLoginCallback() {

  }

  void handleRegisterCallback() {

  }

  @override
  Widget build(BuildContext context) {
    return !isAuthenticated
    ? NoLoggedComponent(
      message: "crear mazos",
      loginCallback: handleLoginCallback,
      registerCallback: handleRegisterCallback,
    )
    : Column(
      children: <Widget>[
        Container(
          child: Text("My decks"),
        ),
      ],
    );
  }
}