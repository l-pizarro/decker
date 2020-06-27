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
// import 'package:decker/theme.dart';
// import 'package:feather_icons_flutter/feather_icons_flutter.dart';

// Search
// import 'package:diacritic/diacritic.dart';


class CreateDeck extends StatefulWidget {
  final List<Carta> cardList;
  final bool loading;

  CreateDeck({
    this.cardList,
    this.loading
  });

  @override
  _CreateDeckState createState() => new _CreateDeckState();
}

class _CreateDeckState extends State<CreateDeck> {

  void initState() {
    super.initState();
  }

  void handleLoginCallback() {

  }

  void handleRegisterCallback() {

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
      children: <Widget>[
        Container(
          child: Text("Create deck"),
        ),
      ],
    );
  }
}