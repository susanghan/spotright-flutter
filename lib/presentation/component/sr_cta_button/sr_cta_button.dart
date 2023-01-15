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
    return SizedBox(
      width: double.infinity,
      height: 88,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: isEnabled ? SrColors.primary : SrColors.gray,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)))),
        onPressed: action,
        child: Text(
          text,
          style: const TextStyle(color: SrColors.white),
        ),
      ),
    );
  }
}
