import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/buttons/sr_cta_button.dart';
import 'package:spotright/presentation/page/edit_profile/edit_profile_controller.dart';
import '../../component/sr_text_field/sr_text_field.dart';
import 'package:image_picker/image_picker.dart';

//Todo : 일단 넘어가고 나중에 내가 다 갈아 엎을게,,,실제 서버랑 연결할 때
//Todo : 프로필 사진, 닉네임 중 하나이상 수정해야 완료 버튼이 활성화됩니다
//Todo : 각각 '프로필 사진 수정 버튼'과 '닉네임타이핑칸'을 누르면 해당 항목을 변경할 수 있습니다
//Todo : 기존 닉네임과 같은 닉네임을 입력했을 때는 완료 버튼이 활성화되지 않습니다
//Todo : 프로필 사진이 없으면 x버튼이 사라지게

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  EditProfileController editProfileController = Get.find();


  final ImageProvider _defaultImage = const AssetImage('assets/user_profile_default_large.png');
  final ImagePicker _picker = ImagePicker();

  ImageProvider? _userProfile;
  dynamic _pickImageError;

  @override
  void initState(){
    editProfileController.editProfileState.isEdited.value = false;
    //서버에서 가져온 _userProfilePath이 비지 않았으면 이미지 반환해 주기.
    _userProfile = editProfileController.userProfilePath.isNotEmpty ? null : _defaultImage;
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
              isEnabled: editProfileController.editProfileState.isEdited.value,
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
                  ),
                ),
                Positioned(
                  //삭제 버튼입니다.
                  top: 12,
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        editProfileController.editProfileState.isEdited.value = true;
                        _userProfile = _defaultImage;
                      });
                    },
                      child: Visibility(
                        visible: _userProfile == _defaultImage ? false : true,
                          child: SvgPicture.asset("assets/delete_button_primary.svg", width: 34, height: 34,))),
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
                child: const Text(
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
              child: SrTextField(hint: userNickname ?? '', maxLines: 1, onChanged: editProfileController.onNicknameChanged)),
          Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Obx(
                () => Text(
                  editProfileController.editProfileState.nicknameValidationMessage,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      color: SrColors.gray2),
                ),
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
        editProfileController.editProfileState.isEdited.value = true;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

}
