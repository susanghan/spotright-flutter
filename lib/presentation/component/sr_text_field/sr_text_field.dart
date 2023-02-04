import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';

class SrTextField extends StatelessWidget {
  SrTextField(
      {Key? key,
      this.suffixIcon,
      this.suffixIconHeight,
      this.suffixIconWidth,
      this.cursorWidth = 1,
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
  final double cursorWidth;
  double? suffixIconHeight, suffixIconWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: TextField(
        controller: controller ?? TextEditingController(),
        cursorColor: SrColors.success,
        cursorWidth: cursorWidth,
        maxLines: maxLines,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        onChanged: onChanged,
        decoration: InputDecoration(
            //아마 suffix 아이콘 사라질 듯, 나중에 허자
            //suffixIconConstraints: BoxConstraints(maxHeight: suffixIconHeight?? 37, maxWidth: suffixIconWidth ?? 80, ),
            suffixIcon: suffixIcon,
            //bottom 일부러 안 넣은 거임, line 여러 개일 때 이거 안 먹더라,,,참고해서 해결행~~~~
            contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 15),
            //Todo: 색 정정 하고 에러일 때 추가함. 수정 필요하면 해주세요.
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                borderSide: const BorderSide(width: 1, color: SrColors.gray1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                borderSide: const BorderSide(width: 1, color: SrColors.success)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                borderSide: const BorderSide(width: 1, color: SrColors.primary)),
            hintText: hint),
      ),
    );
  }
}
