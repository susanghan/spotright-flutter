import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';

//Todo : SrTextFiled) 본문 행간=글자크기 *1.4 ,글자크기:12, 행간:16.8, 본문 영역: 68*296, 상하 여백: 14, 좌우 여백: 16

class SrTextField extends StatelessWidget {
  SrTextField(
      {Key? key,
      this.suffixIcon,
      this.prefixIcon,
      this.suffixIconHeight,
      this.suffixIconWidth,
      this.cursorWidth = 1,
      this.hint = '',
      this.onChanged,
      this.maxLines = 1,
      this.height = 44,
      this.borderRadius = 22,
      this.controller,
      this.backgroundColor,
      this.inputBorder,
      this.enableBorder,
      this.focusInputBorder,
      this.errorInputBorder,
      this.prefixIconConstraints,
      this.enabled = true,
      })
      : super(key: key);

  final String hint;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int maxLines;
  final double height;
  final double borderRadius;
  final TextEditingController? controller;
  final double cursorWidth;
  final bool enabled;
  double? suffixIconHeight, suffixIconWidth;
  Color? backgroundColor;
  InputBorder? inputBorder, enableBorder, focusInputBorder, errorInputBorder;
  BoxConstraints? prefixIconConstraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: TextField(
        controller: controller,
        cursorColor: SrColors.success,
        cursorWidth: cursorWidth,
        maxLines: maxLines,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        onChanged: onChanged,
        enabled: enabled,
        decoration: InputDecoration(
            filled: backgroundColor==null ? false : true,
            fillColor: backgroundColor,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            prefixIconConstraints: prefixIconConstraints,
            //bottom 일부러 안 넣은 거임, line 여러 개일 때 이거 안 먹더라,,,참고해서 해결행~~~~
            contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 15),
            //Todo: 색 정정 하고 에러일 때 추가함. 수정 필요하면 해주세요.
            border: inputBorder ?? OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                borderSide: const BorderSide(width: 1, color: SrColors.gray3)),
            enabledBorder: enableBorder,
            focusedBorder: focusInputBorder ?? OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                borderSide: const BorderSide(width: 1, color: SrColors.success)),
            errorBorder: errorInputBorder ?? OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                borderSide: const BorderSide(width: 1, color: SrColors.primary)),
            hintText: hint),
      ),
    );
  }
}
