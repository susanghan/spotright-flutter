
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/page/edit_profile/edit_profile_state.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  EditProfileController({required this.editProfileState});

  final EditProfileState editProfileState;

  final ImageProvider _defaultProfileImage = const AssetImage('assets/user_profile_default_large.png');
  final ImagePicker _picker = ImagePicker();
  dynamic pickImageError;

  RxBool get isEdited => (serverProfilePath != userProfilePath.value || severNickName != userNickName.value).obs;
  String serverProfilePath = '';
  String severNickName = '감자튀김';
  RxString userProfilePath = ''.obs;
  RxString userNickName = ''.obs;

  ImageProvider? userProfile;

  ImageProvider? get imageProvider {
    print("안녕");
    //만약 userprofilePath가 비었으면 서버에서 이미지 가져오기. 만약 서버에서 가져오기
    if(userProfilePath.value.isEmpty) return null;//serverProfilePath;
    return Image.file(File(userProfilePath.value)).image;
  }

  Future<void> onEditButtonPressed(ImageSource source, {BuildContext? context}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      userProfilePath.value = pickedFile!.path;
    } catch (e) {
      pickImageError = e;
    }
  }


  void onNicknameChanged(String nickname) {
    editProfileState.validateNickname(nickname);
  }

}

