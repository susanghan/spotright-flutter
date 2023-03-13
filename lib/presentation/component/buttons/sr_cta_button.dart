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
    return Container(
      width: double.infinity,
      height: 60,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          if(isEnabled) action();
        },
        color: isEnabled ? SrColors.primary : SrColors.gray,
        splashColor: SrColors.primary,
        highlightColor: SrColors.primary,
        child:Text(
          text,
          style: const TextStyle(color: SrColors.white, fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
    );
  }
}
