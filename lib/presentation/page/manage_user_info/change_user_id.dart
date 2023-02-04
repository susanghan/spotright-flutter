import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/colors.dart';
import '../../component/appbars/default_app_bar.dart';
import '../../component/buttons/sr_cta_button.dart';
import '../../component/sr_text_field/sr_text_field.dart';

class ChangeUserId extends StatefulWidget {
  const ChangeUserId({Key? key}) : super(key: key);

  @override
  State<ChangeUserId> createState() => _ChangeUserIdState();
}

class _ChangeUserIdState extends State<ChangeUserId> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const DefaultAppBar(
        title: "아이디 변경",
        hasBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //ui구현하기 위해서 집어 넣은 의미 없는 것~
            const SizedBox(
              width: double.infinity,
              height: 0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    "새로운 아이디를 입력해 주세요",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: SrColors.black),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: SrTextField(
                      height: 45,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4, 6, 4),
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                              backgroundColor: SrColors.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100))),
                          child: const Text(
                            "중복확인",
                            style: TextStyle(color: SrColors.white, fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14),
                  child: Text(
                    "아이디 제한 캡션입니다",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: SrColors.gray1),
                  ),
                ),
              ],
            ),
            SrCTAButton(
              text: "완료",
              isEnabled: false,
              action: () {},
            ),
          ],
        ),
      ),
    ));
  }
}
