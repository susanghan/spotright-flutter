import 'package:flutter/material.dart';
import 'package:spotright/presentation/component/sr_chip/sr_chip_model.dart';

import '../../common/colors.dart';

class SrChip extends StatefulWidget {
  const SrChip({Key? key, required this.model}) : super(key: key);

  final SrChipModel model;

  @override
  State<SrChip> createState() => _SrChipState();
}

class _SrChipState extends State<SrChip> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Material(
        elevation: 4,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1.5,
              color: widget.model.selected ? widget.model.color : SrColors.white
          ),
          borderRadius: BorderRadius.circular(100),
      ),
        child: ActionChip(
          avatar: Container(width: 11, height: 11,
          decoration: BoxDecoration(
            color: widget.model.color,
            borderRadius: BorderRadius.circular(100)
          ),),
          backgroundColor: SrColors.white,
          onPressed: () {
            if(widget.model.onTab != null) widget.model.onTab!(!widget.model.selected);
          },
          label: Text(
            widget.model.name,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)
          ),
        ),
      ),
    );
  }
}
