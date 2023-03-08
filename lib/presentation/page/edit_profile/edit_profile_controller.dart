import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';
import 'package:spotright/presentation/page/edit_profile/edit_profile_state.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final EditProfileState editProfileState = EditProfileState();

  UserRepository userRepository = Get.find();
  final ImageProvider _defaultProfileImage = const AssetImage('assets/user_profile_default_large.png');
  final ImagePicker _picker = ImagePicker();
  dynamic pickImageError;

  RxBool get ctaActive => ((user.nickname != editProfileState.nickname.value) && (editProfileState.nicknameMessageStatus.value == MessageStatus.enabled)).obs;
  var userProfileState = UserProfileState.defaultState.obs;
  String? serverProfilePath = '';
  RxString userProfilePath = ''.obs;
  UserResponse user = UserResponse(memberId: 0);
  TextEditingController nicknameController = TextEditingController();

  void initState() {
    user = userRepository.userResponse!;
    editProfileState.nickname.value = user.nickname!;
    nicknameController.text = user.nickname!;
    if(user.memberPhoto?.photoUrl!.isNotEmpty ?? false) userProfileState.value = UserProfileState.serverState;
  }

  ImageProvider? get imageProvider {
    switch(userProfileState.value) {
      case UserProfileState.serverState: return null;
      case UserProfileState.galleryState: return Image.file(File(userProfilePath.value), cacheWidth: 720,).image;
      default: return _defaultProfileImage;
    }
  }

  Future<void> onEditButtonPressed(ImageSource source, {BuildContext? context}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      userProfileState.value = UserProfileState.galleryState;
      userProfilePath.value = pickedFile!.path;
    } catch (e) {
      pickImageError = e;
    }
  }

  void get onDeleteButtonPressed{
    userProfilePath.value = '';
    userProfileState.value = UserProfileState.defaultState;
  }

  void onNicknameChanged(String nickname) {
    editProfileState.nickname.value = nickname;
    editProfileState.validateNickname();
  }

  Future<void> onFinished() async {
    Get.back();
    await userRepository.updateNickname(editProfileState.nickname.value);
    userRepository.fetchMyInfo();
  }
}

enum UserProfileState{
  serverState,
  defaultState,
  galleryState
}