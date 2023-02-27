import 'package:flutter/material.dart';

import '../../common/colors.dart';

class SrChip extends StatefulWidget {
  SrChip({
    Key? key,
    this.name = '',
    this.color = const Color(0xffffffff),
    this.selected = true,
    this.onTab,
    this.elevation = 4,
    this.borderColor,
  }) : super(key: key);

  String name;
  Color color;
  bool selected;
  Function(bool)? onTab;
  double elevation;
  Color? borderColor;

  @override
  State<SrChip> createState() => _SrChipState();
}

class _SrChipState extends State<SrChip> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Material(
        elevation: widget.elevation,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1.5,
              color:
                  widget.selected ? widget.color : widget.borderColor ?? SrColors.white),
          borderRadius: BorderRadius.circular(100),
        ),
        child: ActionChip(
          avatar: Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(100)),
          ),
          backgroundColor: SrColors.white,
          onPressed: () {
            if (widget.onTab != null)
              widget.onTab!(!widget.selected);
          },
          label: Text(
            widget.name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: SrColors.black),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
      ),
    );
  }
}
