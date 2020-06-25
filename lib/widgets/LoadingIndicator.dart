import 'package:flutter/material.dart';

// Styling
import 'package:decker/theme.dart';


Widget loadingIndicator(Size size) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(
        strokeWidth: 2,
        backgroundColor: ThemeColors.gray[500],
        valueColor: new AlwaysStoppedAnimation<Color>(ThemeColors.red.withOpacity(0.6))
      ),
      Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Text(
          "Cargando",
          style: TextStyle(
            fontFamily: "SF Pro Text Light",
            color: ThemeColors.gray[200],
            fontSize: 14,
            letterSpacing: 0.4
          ),
        ),
      ),
      SizedBox(height: 56 + (size.width * 0.098))
    ],
  );
}