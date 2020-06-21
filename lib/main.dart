import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'views/MainView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp
      ]
    );
    return MaterialApp(
      title: 'Decker App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => MainView()
      },
    );
  }
}