import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/buttons/sr_cta_button.dart';
import '../../component/sr_text_field/sr_text_field.dart';
import 'package:image_picker/image_picker.dart';

//Todo : 프로필 사진, 닉네임 중 하나이상 수정해야 완료 버튼이 활성화됩니다
//Todo : 각각 '프로필 사진 수정 버튼'과 '닉네임타이핑칸'을 누르면 해당 항목을 변경할 수 있습니다
//Todo : 기존 닉네임과 같은 닉네임을 입력했을 때는 완료 버튼이 활성화되지 않습니다

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  //첨에 서버에서 가져온 user profile path, 없으면 empty로 받을 거 같음. 아마?
  String _userProfilePath = 'ss';
  ImageProvider? _userProfile;

  bool _editFlag = false;

  final ImagePicker _picker = ImagePicker();
  dynamic _pickImageError;
  
  //AssetImage(_pickedFile!.path) 갤러리에서 가져온 이미지

  @override
  void initState(){
    //서버에서 가져온 _userProfilePath이 비지 않았으면 이미지 반환해 주기.
    _userProfile = _userProfilePath.isNotEmpty ? null : const AssetImage('assets/user_profile_none_large.png');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const DefaultAppBar(
        title: "프로필 수정",
        hasBackButton: true,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 36),
        child: Column(
          children: [
            ..._UserProfile(),
            ..._UserNickName("감자튀김"),
            const Spacer(),
            SrCTAButton(
              text: "완료",
              isEnabled: _editFlag,
              action: () {},
            )
          ],
        ),
      ),
    ));
  }

  List<Widget> _UserProfile() {
    return [
      Column(
        children: [
          Container(
            width: 180,
            height: 180,
            child: Stack(
              alignment: Alignment.topRight,
                children: [
                Container(
                  width: 180,
                  height: 180,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: _userProfile
                    //_editProfileFlag ? AssetImage(_pickedFile!.path) : _userProfile.isNotEmpty  ? AssetImage(_pickedFile!.path) : const AssetImage('assets/user_profile_none_large.png'),
                  ),
                ),
                Positioned(
                  //삭제 버튼입니다.
                  top: 12,
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        _editFlag = true;
                        _userProfile = const AssetImage('assets/user_profile_none_large.png');
                      });
                    },
                      child: SvgPicture.asset("assets/delete_button_primary.svg", width: 34, height: 34,)),
                )
              ]
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 28),
              child: InkWell(
                onTap: (){
                  _onEditButtonPressed(ImageSource.gallery);
                },
                child: Text(
                  "프로필 사진 수정",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: SrColors.gray1),
                ),
              ))
        ],
      )
    ];
  }

  List<Widget> _UserNickName(String? userNickname) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "닉네임",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: SrColors.black),
                textAlign: TextAlign.left,
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: SrTextField(hint: userNickname ?? '', maxLines: 1)),
          Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "닉네임 규정 캡션입니다",
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                    color: SrColors.gray2),
              ))
        ],
      )
    ];
  }

  Future<void> _onEditButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      setState(() {
        _userProfile = Image.file(File(pickedFile!.path)).image;
        _editFlag = true;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

}
