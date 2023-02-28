import 'package:flutter/material.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';

//Todo : SrTextFiled) 본문 행간=글자크기 *1.4 ,글자크기:12, 행간:16.8, 본문 영역: 68*296, 상하 여백: 14, 좌우 여백: 16

class SrTextField extends StatefulWidget {
  SrTextField({
    Key? key,
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
    this.contentPadding,
    this.maxLength,
    this.onSubmitted
  }) : super(key: key);

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
  final EdgeInsets? contentPadding;
  final int? maxLength;
  ValueChanged<String>? onSubmitted;

  @override
  State<SrTextField> createState() => SrTextField_State();
}

class SrTextField_State extends State<SrTextField> {
  int contentLength = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.only(bottom: 8),
        height: widget.height,
        child: TextField(
          controller: widget.controller,
          cursorColor: SrColors.success,
          cursorWidth: widget.cursorWidth,
          maxLines: widget.maxLines,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          onChanged: _onChanged,
          enabled: widget.enabled,
          maxLength: widget.maxLength,
          onSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
            counterText: "",
              filled: !(widget.backgroundColor == null),
              fillColor: widget.backgroundColor,
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              prefixIconConstraints: widget.prefixIconConstraints,
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              //Todo: 색 정정 하고 에러일 때 추가함. 수정 필요하면 해주세요.
              border: widget.inputBorder ??
                  OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(widget.borderRadius)),
                      borderSide:
                      const BorderSide(width: 1, color: SrColors.gray3)),
              enabledBorder: widget.enableBorder,
              focusedBorder: widget.focusInputBorder ??
                  OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(widget.borderRadius)),
                      borderSide:
                      const BorderSide(width: 1, color: SrColors.success)),
              errorBorder: widget.errorInputBorder ??
                  OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(widget.borderRadius)),
                      borderSide:
                      const BorderSide(width: 1, color: SrColors.primary)),
              hintText: widget.hint),
        ),
      ),
      if(widget.maxLength != null) Row(
          mainAxisAlignment: MainAxisAlignment.end, children: [Text("$contentLength/${widget.maxLength}", style: SrTypography.body4medium.copy(color: SrColors.gray2),)])
    ]);
  }

  void _onChanged(String text) {
    widget.onChanged?.call(text);
    setState(() {
      contentLength = text.length;
    });
  }
}