import 'package:flutter/material.dart';

class ThemeColors {
  ThemeColors._();

  static const _gray = 0xff2B2B2B;
  static const _red = 0xffE53E3E;
  static const _black = 0xff000000;

  static const MaterialColor gray = const MaterialColor(
    _gray,
    const <int, Color>{
      100: const Color(0xffD2D2D2),
      200: const Color(0xff777777),
      300: const Color(0xff5C5C5C),
      400: const Color(0xff515151),
      500: const Color(_gray),
      600: const Color(0xff1F1F1F),
      700: const Color(0xff181818),
    },
  );

  static const MaterialColor red = const MaterialColor(
    _red,
    const <int, Color>{
      500: const Color(_red),
    },
  );

  static const MaterialColor black = const MaterialColor(
    _black,
    const <int, Color>{
      500: const Color(_black),
    },
  );
}