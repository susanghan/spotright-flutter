import 'dart:ui';

import 'package:flutter/material.dart';

class SrColors {
  static const Color primary = Color(0xffFD4F18);
  static const Color black = Color(0xff000000);
  static const Color gray = Color(0xffB0B0B0);
  static const Color gray1 = Color(0xff6c6c6c);
  static const Color gray2 = Color(0xffcccccc);
  static const Color gray3 = Color(0xffe9e9e9);
  static const Color gray9e = Color(0xff9e9e9e);
  static const Color darkGray = Color(0xff6C6C6C);
  static const Color white = Color(0xffffffff);

  static const Color restaurant = Color(0xffFFD771);
  static const Color cafe = Color(0xffFF83E4);
  static const Color tour = Color(0xffA0DE6F);
  static const Color accommodation = Color(0xff5D7BE4);
  static const Color shopping = Color(0xff9F52DC);
  static const Color hospital = Color(0xff72CFD4);
  static const Color etc = Color(0xff828080);

  static const Color kakao = Color(0xffFEE500);

  static const Color success = Color(0xff0066FF);

  static const MaterialColor materialPrimary = MaterialColor(
    0xffFD4F18,
    <int, Color>{
      50: Color(0xffFD4F18),
      100: Color(0xffFD4F18),
      200: Color(0xffFD4F18),
      300: Color(0xffFD4F18),
      400: Color(0xffFD4F18),
      500: primary,
      600: Color(0xffFD4F18),
      700: Color(0xffFD4F18),
      800: Color(0xffFD4F18),
      900: Color(0xffFD4F18),
    },
  );
}