import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/sr_cta_button/sr_cta_button_model.dart';

class SrCTAButton extends StatelessWidget {
  const SrCTAButton({Key? key, required this.srCTAButtonModel}) : super(key: key);

  final SrCTAButtonModel srCTAButtonModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: srCTAButtonModel.isEnabled ? SrColors.primary : SrColors.gray,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100))
          )
        ),
        onPressed: srCTAButtonModel.action,
        child: Text(srCTAButtonModel.text,
        style: const TextStyle(
          color: SrColors.white
        ),),
      ),
    );
  }
}
