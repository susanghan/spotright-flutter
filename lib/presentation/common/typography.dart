import 'package:flutter/material.dart';

class SrTypography {
  static const TextStyle body2semi = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    fontWeight: FontWeight.w600,
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