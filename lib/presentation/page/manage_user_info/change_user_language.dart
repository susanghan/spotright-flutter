import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/page/manage_user_info/change_user_language_controller.dart';
import '../../common/colors.dart';
import '../../component/appbars/default_app_bar.dart';
import '../../component/divider/sr_divider.dart';

class ChangeUserLanguage extends StatefulWidget {
  ChangeUserLanguage({Key? key}) : super(key: key);

  @override
  State<ChangeUserLanguage> createState() => _ChangeUserLanguageState();
}

class _ChangeUserLanguageState extends State<ChangeUserLanguage> {
  ChangeUserLanguageController languageController = Get.put(ChangeUserLanguageController());


  @override
  void initState() {
    super.initState();
    languageController.initState(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: DefaultAppBar(
        title: "setting_language".tr,
        hasBackButton: true,
      ),
      body: Column(
        children: [
          SrDivider(),
          _ListText(listText: "한국어", action: () {
            languageController.changeLanguage(Locale('ko', 'KR'));
          }),
          SrDivider(),
          _ListText(listText: "English", action: () {
            languageController.changeLanguage(Locale('en', 'US'));
          }),
          SrDivider(),
        ],
      ),
    ));
  }

  Widget _ListText({required String listText, required Function() action}) {
    return InkWell(
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
    );
  }
}
