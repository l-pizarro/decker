import 'package:flutter/material.dart';

// Styling
import 'package:decker/theme.dart';


class NoLoggedComponent extends StatefulWidget {
  final String message;
  final Function() loginCallback;
  final Function() registerCallback;
  final bool loading;

  NoLoggedComponent({
    this.message,
    this.loginCallback,
    this.registerCallback,
    this.loading
  });

  @override
  _NoLoggedComponentState createState() => new _NoLoggedComponentState();
}

class _NoLoggedComponentState extends State<NoLoggedComponent> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.width * 0.3),
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/Decker.png"),
                )
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Decker",
              style: TextStyle(
                fontFamily: "SF Pro Text Regular",
                // color: ThemeColors.gray[100],
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2
              ),
            )
          ],
        ),
        SizedBox(height: size.width * 0.25),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.12),
          child: Text(
            "Para poder " + widget.message + " es necesario que inicies sesión",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ThemeColors.gray[100],
              fontFamily: "SF Pro Text Light",
              fontSize: 14,
              letterSpacing: 0.2
            ),
          ),
        ),
         SizedBox(height: size.width * 0.2),
        ButtonTheme(
          minWidth: 180.0,
          child: RaisedButton(
            elevation: 0,
            color: ThemeColors.red,
            onPressed: () {
              widget.loginCallback();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Ingresar",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "SF Pro Text Regular",
                  letterSpacing: 0.2
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: size.width * 0.06),
        ButtonTheme(
          minWidth: 180.0,
          child: RaisedButton(
            elevation: 0,
            color: ThemeColors.gray[500],
            onPressed: () {
              widget.registerCallback();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Registrarme",
                style: TextStyle(
                  color: ThemeColors.gray[100].withOpacity(0.8),
                  fontFamily: "SF Pro Text Regular",
                  letterSpacing: 0.2
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}