import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.only(bottom : 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 70),
                    child: Text("\u{1F61F}", style: TextStyle(fontSize: 100),)),
                const Text("정말 탈퇴하실 건가요? \n 이대로 간다니 아쉬워요", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: SrColors.gray2 ),),
                SrCTAButton(
                  text: "계정 삭제",
                  isEnabled: false,
                  action: (){Get.to(DeactivateAccount());},
                )

              ],
            ),
          )
    ));
  }

}
