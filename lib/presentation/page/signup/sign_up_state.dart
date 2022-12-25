import 'package:get/get.dart';

class SignUpState {
  final Map<MessageStatus, String> _messageMap = {
    MessageStatus.defaultMessage: '영문자, 숫자, 특수기호를 사용하여 ?자~??자',
    MessageStatus.checkLength: '아이디는 ?~??자여야 합니다.',
    MessageStatus.checkSpecialCharacter: '특수문자는 ?, ?, ? 만 사용 가능합니다.',
    MessageStatus.checkDuplicate: '중복된 아이디입니다.',
    MessageStatus.enabled: '사용가능한 아이디입니다.',
    MessageStatus.empty: '',
  };

  var ctaActive = false.obs;
  var messageStatus = MessageStatus.defaultMessage.obs;
  String get validationMessage => _messageMap[messageStatus.value]!;
}

enum MessageStatus {
  defaultMessage,
  checkLength,
  checkSpecialCharacter,
  checkDuplicate,
  enabled,
  empty
}
