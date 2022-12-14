import 'package:flutter/material.dart';

class Palette {
  static const Color textColor = Color(0xFF000000);
  static const Color firebaseBlack = Color(0xFF221F20);
  static const Color firebaseOrange = Color(0xFFF57C00);
  static const Color firebaseAmber = Color(0xFFFFA000);
  static const Color firebaseYellow = Color(0xFFFFCA28);
  static const Color firebaseGrey = Color(0xFFECEFF1);
  static const Color googleBackground = Color(0xFF4285F4);

  static const MaterialColor kToDark = MaterialColor(
    0xffFF9100, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffFFF3E0), //10%
      100: Color(0xffFFE0B2), //20%
      200: Color(0xffFFCC80), //30%
      300: Color(0xffFFB74D), //40%
      400: Color(0xffFFA726), //50%
      500: Color(0xffFF9800), //60%
      600: Color(0xffFB8C00), //70%
      700: Color(0xffF57C00), //80%
      800: Color(0xffEF6C00), //90%
      900: Color(0xffE65100), //100%
    },
  );
}

// Palette for dark mode

class PaletteDark {
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color firebaseBlack = Color(0xFF221F20);
  static const Color firebaseOrange = Color(0xFFF57C00);
  static const Color firebaseAmber = Color(0xFFFFA000);
  static const Color firebaseYellow = Color(0xFFFFCA28);
  static const Color firebaseGrey = Color(0xFFECEFF1);
  static const Color googleBackground = Color(0xFF4285F4);

  static const MaterialColor kToDark = MaterialColor(
    0xffFF9100, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffFFF3E0), //10%
      100: Color(0xffFFE0B2), //20%
      200: Color(0xffFFCC80), //30%
      300: Color(0xffFFB74D), //40%
      400: Color(0xffFFA726), //50%
      500: Color(0xffFF9800), //60%
      600: Color(0xffFB8C00), //70%
      700: Color(0xffF57C00), //80%
      800: Color(0xffEF6C00), //90%
      900: Color(0xffE65100), //100%
    },
  );
}
