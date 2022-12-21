import 'package:flutter/material.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/srtextfield/sr_text_field_model.dart';

class SrTextField extends StatelessWidget {
  const SrTextField({Key? key, this.srTextFieldModel}) : super(key: key);

  final SrTextFieldModel? srTextFieldModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      child: TextField(
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                borderSide: BorderSide(
                    width: 1, color: SrColors.gray
                )
            ),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                borderSide: BorderSide(
                    width: 1, color: SrColors.primary
                )
            ),
            hintText: srTextFieldModel?.hint
        ),
      ),
    );
  }
}
