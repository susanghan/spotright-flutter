import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/colors.dart';
import '../../component/appbars/default_app_bar.dart';
import '../../component/divider/sr_divider.dart';

class ChangeUserLanguage extends StatelessWidget {
  const ChangeUserLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const DefaultAppBar(
        title: "언어 설정",
        hasBackButton: true,
      ),
      body: Column(
        children: [
          SrDivider(),
          ..._ListText(listText: "한국어", action: () {}),
          SrDivider(),
          ..._ListText(listText: "English", action: () {}),
          SrDivider(),
        ],
      ),
    ));
  }

  List<Widget> _ListText(
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
