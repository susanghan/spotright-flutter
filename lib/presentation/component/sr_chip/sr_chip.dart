import 'package:flutter/material.dart';

import '../../common/colors.dart';

class SrChip extends StatefulWidget {
  const SrChip({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  State<SrChip> createState() => _SrChipState();
}

class _SrChipState extends State<SrChip> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      side: BorderSide(
          color: selected ? SrColors.black : SrColors.white
      ),
      backgroundColor: SrColors.white,
      onPressed: () {
        setState(() {
          selected = !selected;
        });
      },
      label: Text(
        widget.text,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
      ),
    );
  }
}
