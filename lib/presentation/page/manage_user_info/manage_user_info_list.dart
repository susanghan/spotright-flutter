import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/page/manage_user_info/change_user_birth.dart';
import 'package:spotright/presentation/page/manage_user_info/change_user_id.dart';
import '../../common/colors.dart';

class ManageUserInfoList extends StatelessWidget {
  const ManageUserInfoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const DefaultAppBar(
        title: "개인 정보 관리",
        hasBackButton: true,
      ),
      body: Column(
        children: [
          ..._Divider(1),
          ..._InfoLisetText(
              listText: "아이디 변경",
              action: () {
                Get.to(ChangeUserId());
              }),
          ..._Divider(1),
          ..._InfoLisetText(
              listText: "생년월일 변경",
              action: () {
                Get.to(ChangeUserBirth());
              }),
          ..._Divider(1),
        ],
      ),
    ));
  }

  List<Widget> _Divider(double thickness) {
    return [
      Divider(
        thickness: thickness,
        color: SrColors.gray3,
      )
    ];
  }

  List<Widget> _InfoLisetText(
      {required String listText, required Function() action}) {
    return [
      InkWell(
        onTap: action,
        child: Container(
            height: 50,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 32),
            child: Text(
              listText,
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                  color: SrColors.black),
            )),
      )
    ];
  }
}
