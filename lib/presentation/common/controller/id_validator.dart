class IdValidator {

  final Map<IdMessageStatus, String> idMessageMap = {
    IdMessageStatus.defaultMessage: "영문자, 숫자, 특수문자('-', '_')를 사용해 입력해 주세요",
    IdMessageStatus.checkLength: '아이디는 6~16자여야 합니다',
    IdMessageStatus.checkDuplicate: '중복된 아이디입니다',
    IdMessageStatus.enabled: '사용 가능한 아이디입니다',
    IdMessageStatus.unavailable: '사용할 수 없는 아이디입니다',
    IdMessageStatus.empty: '중복 검사를 해주세요',
  };

  IdMessageStatus validate(String id) {
    final regex = RegExp(r'^([0-9a-zA-Z-_]{6,16})$');
    if (regex.hasMatch(id)) {
      return IdMessageStatus.empty;
    }

    if (id.isEmpty) {
      return IdMessageStatus.defaultMessage;
    }
    if (id.length < 6 || id.length > 16) {
      return IdMessageStatus.checkLength;
    }

    return IdMessageStatus.defaultMessage;
  }
}

enum IdMessageStatus {
  defaultMessage,
  checkLength,
  checkSpecialCharacter,
  checkDuplicate,
  enabled,
  unavailable,
  empty,
}