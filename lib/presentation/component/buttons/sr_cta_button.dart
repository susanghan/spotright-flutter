import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotright/presentation/common/colors.dart';

class SrCTAButton extends StatelessWidget {
  const SrCTAButton(
      {Key? key, this.text = '', this.isEnabled = true, required this.action})
      : super(key: key);

  final String text;
  final bool isEnabled;
  final Function() action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: 88,
        padding: EdgeInsets.only(top: 20),
        color: isEnabled ? SrColors.primary : SrColors.gray,
        child: Text(
          text,
          style: const TextStyle(color: SrColors.white),
        ),
      ),
    );
  }
}
