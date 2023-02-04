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

  RxBool get isEdited => (userProfileState.value !=UserProfileState.serverState || severNickName != userNickName.value).obs;
  var userProfileState = UserProfileState.serverState.obs;
  String? serverProfilePath = '';
  String? severNickName = '';
  RxString userProfilePath = ''.obs;
  RxString userNickName = ''.obs;

  ImageProvider? get imageProvider {
    if(userProfileState.value == UserProfileState.serverState) return null;
    if(userProfileState.value == UserProfileState.galleryState) return Image.file(File(userProfilePath.value), cacheWidth: 720,).image;
    if(userProfileState.value == UserProfileState.defaultState) return _defaultProfileImage;
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
    editProfileState.validateNickname(nickname);
  }

}

enum UserProfileState{
  serverState,
  defaultState,
  galleryState
}