import 'package:get/get.dart';

class EditProfileState {
  final Map<MessageStatus, String> _nicknameMessageMap = {
    MessageStatus.defaultMessage: "한글 혹은 영문자를 사용해 10자 이내로 입력해 주세요.",
    MessageStatus.checkLength: '닉네임은 10자 이내여야 합니다.',
    MessageStatus.checkDuplicate: '한글 혹은 영문자만 입력해 주세요.',
    MessageStatus.enabled: '사용 가능한 닉네임입니다.',
    MessageStatus.empty: '',
  };

  var nicknameMessageStatus = MessageStatus.defaultMessage.obs;
  String get nicknameValidationMessage => _nicknameMessageMap[nicknameMessageStatus.value]!;

  void validateNickname(String nickname) {
    final regex = RegExp(r'^([a-zA-Zㄱ-ㅎ가-힣]{1,10})$');
    if (regex.hasMatch(nickname)) {
      nicknameMessageStatus.value = MessageStatus.enabled;
      return;
    }
    if (nickname.isEmpty) {
      nicknameMessageStatus.value = MessageStatus.defaultMessage;
    } else if (nickname.length > 10) {
      nicknameMessageStatus.value = MessageStatus.checkLength;
    } else {
      nicknameMessageStatus.value = MessageStatus.defaultMessage;
    }
  }
}

enum MessageStatus {
  defaultMessage,
  checkLength,
  checkSpecialCharacter,
  checkDuplicate,
  enabled,
  empty
}
