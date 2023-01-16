import 'package:flutter/material.dart';
import 'package:spotright/presentation/common/colors.dart';

class SrTextField extends StatelessWidget {
  SrTextField({Key? key, this.suffixIcon, this.hint = '', this.onChanged}) : super(key: key);

  final String hint;
  final Function(String)? onChanged;
  Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      child: TextField(
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.all(12),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                borderSide: BorderSide(
                    width: 1, color: SrColors.gray1
                )
            ),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                borderSide: BorderSide(
                    width: 1, color: SrColors.primary
                )
            ),
            hintText: hint
        ),
      ),
    );
  }
}
