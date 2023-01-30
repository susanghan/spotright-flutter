import 'package:flutter/material.dart';
import 'package:spotright/presentation/common/colors.dart';

class SrTextField extends StatelessWidget {
  SrTextField(
      {Key? key,
      this.suffixIcon,
      this.hint = '',
      this.onChanged,
      this.maxLines = 1,
      this.height = 44,
      this.borderRadius = 22,
      this.controller})
      : super(key: key);

  final String hint;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final int maxLines;
  final double height;
  final double borderRadius;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: TextField(
        controller: controller ?? TextEditingController(),
        maxLines: maxLines,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        onChanged: onChanged,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                borderSide: BorderSide(width: 1, color: SrColors.gray1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                borderSide: BorderSide(width: 1, color: SrColors.primary)),
            hintText: hint),
      ),
    );
  }
}
