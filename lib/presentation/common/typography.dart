import 'package:flutter/material.dart';


//fontSize : 20 => body1/ 15 => body2/ 14 => body3/ 12 => body4
//fontWeight : w700 => bold /w600 => semi/ w500 => medium/ w400 => regular/ w300 => light
class SrTypography {
  static const TextStyle body1semi = TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle body1light = TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle body2semi = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle body2medium = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
  );


  static const TextStyle body2light = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle body3semi = TextStyle(
    color: Colors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle body3medium = TextStyle(
    color: Colors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle body3regular = TextStyle(
    color: Colors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle body4bold = TextStyle(
    color: Colors.black,
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle body4medium = TextStyle(
    color: Colors.black,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle body4light = TextStyle(
    color: Colors.black,
    fontSize: 12.0,
    fontWeight: FontWeight.w300,
  );
}

extension TextStyleExtension on TextStyle {
  TextStyle copy({Color? color, TextDecoration? decoration}) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      decoration: decoration,
    );
  }
}