import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/data/file/file_repository.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';
import 'package:spotright/presentation/page/edit_profile/edit_profile_state.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final EditProfileState editProfileState = EditProfileState();
  final FileRepository fileRepository = Get.find();

  void initState() {
    userResponse.value = userRepository.userResponse!;

    if(userResponse.value.memberPhoto?.photoUrl!.isNotEmpty ?? false) userProfileState.value = UserProfileState.serverState;
    userProfilePath.value = '';

    TextEditingController nicknameController = TextEditingController();
    editProfileState.nickname.value = userResponse.value.nickname ?? '';
    nicknameController.text = userResponse.value.nickname ?? '';
    userNickname.value = userResponse.value.nickname ?? '';

    ctaActive.value = false;

    imageProvider;
  }

  //**user 정보
  UserRepository userRepository = Get.find();
  Rx<UserResponse> userResponse = Rx<UserResponse>(UserResponse(memberId: 0));

  //**프로필 사진
  var userProfileState = UserProfileState.defaultState.obs;
  RxString userProfilePath = ''.obs;

  //**사진 ImageProvider
  final ImageProvider _defaultProfileImage = const AssetImage('assets/user_profile_default_large.png');
  final ImagePicker _picker = ImagePicker();
  dynamic pickImageError;

  //**닉네임
  TextEditingController nicknameController = TextEditingController();
  RxString userNickname = ''.obs;

  //**완료 버튼
  RxBool get ctaActive => ((userNickname.value != userResponse.value.nickname ) && (editProfileState.nicknameMessageStatus.value == MessageStatus.enabled)).obs;

  ImageProvider? get imageProvider {
    switch(userProfileState.value) {
      case UserProfileState.serverState: return NetworkImage(userResponse.value.memberPhoto!.photoUrl!);
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

  Future<void> onDeleteButtonPressed() async {
    userProfilePath.value = '';
    userProfileState.value = UserProfileState.defaultState;
  }

  void onNicknameChanged(String nickname) {
    editProfileState.nickname.value = nickname;
    editProfileState.validateNickname();
    userNickname.value = nickname;
  }

  Future<void> onFinished() async {
    if(userProfilePath.value.isEmpty){
      fileRepository.postProfileFile(null, "");
    }
    else{
      updateProfilePhoto();
    }

    Get.back();
    await userRepository.updateNickname(editProfileState.nickname.value);
    userRepository.fetchMyInfo();
  }

  Future<void> updateProfilePhoto() async {
    var _userProfilePath = userProfilePath.value;
    String mediaType = _userProfilePath.split(".").removeLast();
    fileRepository.postProfileFile(userProfilePath.value, mediaType);
  }
}

enum UserProfileState{
  serverState,
  defaultState,
  galleryState
}