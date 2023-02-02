import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/page/edit_profile/edit_profile_state.dart';

class EditProfileController extends GetxController {
  EditProfileController({required this.editProfileState});

  final EditProfileState editProfileState;

  //첨에 서버에서 가져온 user profile path, 없으면 empty로 받을 거 같음. 아마?
  String userProfilePath = '';
  String userNickName = '';

  void onNicknameChanged(String nickname) {
    editProfileState.validateNickname(nickname);
  }

}