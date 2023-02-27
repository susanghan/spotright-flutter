import 'package:flutter/material.dart';

class SrTypography {
  static const TextStyle body1semi = TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle body2semi = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    fontWeight: FontWeight.w600,
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
  TextStyle copy({Color? color}) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
    );
  }
}