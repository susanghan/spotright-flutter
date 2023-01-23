import 'package:flutter/material.dart';
import 'package:spotright/presentation/common/colors.dart';

class SrCheckBox extends StatefulWidget {
  SrCheckBox({Key? key, this.size = 24, required this.value, required this.onChanged}) : super(key: key);

  double size;
  bool value;
  Function(bool checked) onChanged;

  @override
  State<SrCheckBox> createState() => _SrCheckBoxState();
}

class _SrCheckBoxState extends State<SrCheckBox> {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        padding: EdgeInsets.all(3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: SrColors.gray2,
            width: 1.5,
          )
        ),
        child: _Circle()
      ),
    );
  }

  Widget _Circle() {
    if(!widget.value) return SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: SrColors.primary,
        borderRadius: BorderRadius.circular(100)
      ),
    );
  }
}
