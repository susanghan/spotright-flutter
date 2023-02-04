import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/page/deactivate_account/deactivate_account_pre.dart';
import 'package:spotright/presentation/page/edit_profile/edit_profile.dart';
import 'package:spotright/presentation/page/manage_user_info/change_user_language.dart';
import 'package:spotright/presentation/page/manage_user_info/manage_user_info_list.dart';
import '../../common/colors.dart';
import '../../component/divider/sr_divider.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const DefaultAppBar(
          title: "마이페이지",
          hasBackButton: true,
        ),
        body: Container(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              ..._UserProfile(false),
              SrDivider(height: 4,),
              ..._ListText(listText: "개인정보관리", action: () {Get.to(ManageUserInfoList()); }),
              ..._ListText(listText: "차단사용자관리"),
              ..._ListText(listText: "언어설정", action: () { Get.to(ChangeUserLanguage());}),
              SrDivider(),
              ..._ListText(listText: "오픈소스라이센스"),
              ..._ListText(listText: "개인정보 처리방침"),
              ..._ListText(listText: "버전정보 1.00 (128)"),
              SrDivider(),
              ..._ListText(listText: "로그아웃"),
              SrDivider(),
              const Spacer(),
             InkWell(
               onTap: (){
                 Get.to(DeactivateAccountPre());
               },
                 child: const Text("계정 삭제", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: SrColors.gray1),))
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _UserProfile(bool hasUserPicture) {
    return [
      Padding(
          padding: EdgeInsets.only(top: 12, bottom: 18),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: 80,
                height: 80,
                child: CircleAvatar(
                    radius: 100,
                    backgroundImage: hasUserPicture ? null : const AssetImage('assets/user_profile_default_small.png'),
                    //Todo: 아래 각각은 되는데 합치면 안 됨. why?
                    //backgroundImage: NetworkImage('https://picsum.photos/200')
                    //backgroundImage : AssetImage('assets/user_profile_none_small.png')
                ),
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
                        "지혜원",
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
          ))
    ];
  }

  List<Widget> _ListText({required String listText, Function()? action}) {
    return [
      InkWell(
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
      )
    ];
  }
}
