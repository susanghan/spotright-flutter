import 'package:flutter/cupertino.dart';

class SrChipModel {
  SrChipModel({
    this.name = '',
    this.color = const Color(0xffffffff),
    this.selected = true,
    this.onTab,
  });

  String name;
  Color color;
  bool selected;
  Function(bool)? onTab;
}