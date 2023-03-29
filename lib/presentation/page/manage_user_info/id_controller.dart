import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/presentation/page/signup/sign_up_state.dart';

class IdController extends GetxController {
  final Map<MessageStatus, String> _idMessageMap = {
    MessageStatus.defaultMessage: "영문자, 숫자, 특수문자('-', '_')를 사용해 입력해 주세요.",
    MessageStatus.checkLength: '아이디는 6~16자여야 합니다.',
    MessageStatus.checkDuplicate: '중복된 아이디입니다.',
    MessageStatus.enabled: '사용 가능한 아이디입니다.',
    MessageStatus.empty: '',
  };

  TextEditingController textController = TextEditingController();
  var idMessageStatus = MessageStatus.defaultMessage.obs;
  RxString get idValidationMessage => _idMessageMap[idMessageStatus.value]!.obs;
  UserRepository userRepository = Get.find();
  RxBool ctaActive = false.obs;
  RxString newId = "".obs;

  void initState() {
    textController.text = userRepository.userResponse!.spotrightId!;
  }

  Future<void> verifyId() async {
    if(idMessageStatus.value != MessageStatus.empty) return;

    bool res = await userRepository.verifyDuplicatedId(newId.value) == 'NON_EXISTING_SPOTRIGHTID';
    ctaActive.value = res;
    if(res) {
      idMessageStatus.value = MessageStatus.enabled;
    }
  }

  void onChangeText(String text) {
    _validateId(text);
    newId.value = text;
    ctaActive.value = false;
  }

  void _validateId(String id) {
    final regex = RegExp(r'^([0-9a-zA-Z-_]{6,16})$');
    if (regex.hasMatch(id)) {
      idMessageStatus.value = MessageStatus.empty;
      return;
    }

    if (id.isEmpty) {
      idMessageStatus.value = MessageStatus.defaultMessage;
    } else if (id.length < 6 || id.length > 16) {
      idMessageStatus.value = MessageStatus.checkLength;
    } else {
      idMessageStatus.value = MessageStatus.defaultMessage;
    }
  }

  Future<void> onFinished() async {
    Get.back();
    await userRepository.updateId(newId.value);
    userRepository.fetchMyInfo();
  }
}