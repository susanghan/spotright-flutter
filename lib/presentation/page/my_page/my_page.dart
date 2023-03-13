import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/page/block_list/block_list.dart';
import 'package:spotright/presentation/page/deactivate_account/deactivate_account_pre.dart';
import 'package:spotright/presentation/page/edit_profile/edit_profile.dart';
import 'package:spotright/presentation/page/login/Login.dart';
import 'package:spotright/presentation/page/manage_user_info/change_user_language.dart';
import 'package:spotright/presentation/page/manage_user_info/manage_user_info_list.dart';
import 'package:spotright/presentation/page/my_page/my_page_controller.dart';
import 'package:spotright/presentation/page/opensource_licence/OpenSourceLisence.dart';
import '../../common/colors.dart';
import '../../component/divider/sr_divider.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  MyPageController myPageController = Get.put(MyPageController());
  UserRepository userRepository = Get.find();

  @override
  void initState() {
    super.initState();
    myPageController.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
          title: "마이페이지",
          hasBackButton: true,
        ),
        body: Obx(() => SingleChildScrollView(
          child: Column(
            children: [
              _UserProfile(),
              SrDivider(height: 3,),
              _ListText(listText: "개인정보관리", action: () {Get.to(ManageUserInfoList()); }),
              _ListText(listText: "차단사용자관리", action: () => Get.to(BlockList())),
              _ListText(listText: "settingLanguage".tr, action: () { Get.to(ChangeUserLanguage());}),
              SrDivider(),
              _ListText(listText: "오픈소스라이센스", action: () => Get.to(OpenSourceLicence())),
              _ListText(listText: "개인정보 처리방침"),
              _ListText(listText: "버전정보 ${myPageController.versionName} (${myPageController.buildNumber})"),
              SrDivider(),
              _ListText(listText: "로그아웃", action: () async {
                await userRepository.logout();
                Get.offAll(Login());
              }),
              SrDivider(),
            ],
          ),
        )),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: InkWell(
              onTap: (){
                Get.to(DeactivateAccountPre());
              },
              child: Text("계정삭제",textAlign: TextAlign.center,style: SrTypography.body4light.copy(color: SrColors.gray1)),
            )
        ),
      ),
    );
  }

  Widget _UserProfile() {
    return
      Padding(
          padding: EdgeInsets.only(top: 12, bottom: 18),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: 80,
                height: 80,
                //color: SrColors.white,
                child: Obx(() => CircleAvatar(
                  backgroundColor: SrColors.white,
                  radius: 100,
                  backgroundImage: myPageController.hasPhoto.value ? NetworkImage(myPageController.userResponse.value.memberPhoto!.photoUrl!)
                      : AssetImage('assets/user_profile_default_small.png') as ImageProvider,
                ),)
              ),
              GestureDetector(
                onTap: (){
                  Get.to(EditProfile());
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 18, height: 18,),
                      Text(
                        myPageController.userResponse.value.nickname ?? "UnKnown",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: SrColors.black),
                      ),
                      IconButton(
                        icon: SvgPicture.asset("assets/edit.svg"),
                        onPressed: () {Get.to(EditProfile());},
                        iconSize: 18,
                        padding: const EdgeInsets.only(left: 3),
                        constraints: const BoxConstraints(),
                      )
                    ],
                  ),
                ),
              )
            ],
          ));
  }

  Widget _ListText({required String listText, Function()? action}) {
    return InkWell(
        onTap: action,
        child: Container(
          height: 51,
          padding: const EdgeInsets.only(left: 32),
          alignment: Alignment.centerLeft,
          child: Text(
            listText,
            style: const TextStyle(
                fontWeight: FontWeight.w300, fontSize: 15, color: Colors.black),
          ),
        ),
      );
  }
}
