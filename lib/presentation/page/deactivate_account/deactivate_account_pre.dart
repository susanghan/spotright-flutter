import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/page/deactivate_account/deactivate_account.dart';
import '../../component/buttons/sr_cta_button.dart';

class DeactivateAccountPre extends StatelessWidget {
  const DeactivateAccountPre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const DefaultAppBar(
              title: "계정 삭제",
              hasBackButton: true,
            ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //ui구현하기 위해서 집어 넣은 의미 없는 것~
                const SizedBox(width: double.infinity, height: 60, ),
                Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: SvgPicture.asset("assets/deactivate_emoji.svg")),
                    const Text(
                      "정말 탈퇴하실 건가요? \n 이대로 간다니 아쉬워요",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: SrColors.gray2),
                    ),
                  ],
                ),
                SrCTAButton(
                  text: "계정 삭제",
                  isEnabled: true,
                  action: () {
                    Get.to(DeactivateAccount());
                  },
                ),
              ],
            ),
          ),
    ));
  }
}
