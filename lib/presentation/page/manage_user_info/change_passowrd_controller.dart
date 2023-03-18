import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:spotright/data/user/user_repository.dart';

class ChangePasswordController extends GetxController {
  UserRepository userRepository = Get.find();

  final Map<MessageStatus, String> _passwordMessageMap = {
    MessageStatus.defaultMessage: "영문, 숫자, 특수문자(#\$@!%&*?) 조합 8~30자",
    MessageStatus.checkLength: '비밀번호는 6~16자여야 합니다.',
    MessageStatus.enabled: '사용 가능한 비밀번호입니다.',
    MessageStatus.empty: '',
  };

  RxString password = "".obs;
  RxString passwordConfirm = "".obs;
  bool get ctaActive => (passwordMessageStatus.value == MessageStatus.enabled) && (password.value == passwordConfirm.value);
  var passwordMessageStatus = MessageStatus.defaultMessage.obs;
  String get passwordValidationMessage => _passwordMessageMap[passwordMessageStatus]!;

  void onPasswordChanged(String text) {
    password.value = text;
    _validatePassword();
  }

  void onPasswordConfirmChanged(String text) {
    passwordConfirm.value = text;
  }

  Future<void> changePassword() async {
    bool res = await userRepository.updatePassword(password.value, passwordConfirm.value);
    Get.back();
    String toastMessage = res ? "비밀번호를 변경했습니다." : "오류가 발생했습니다.";
    Fluttertoast.showToast(msg: toastMessage);
  }

  void _validatePassword() {
    final specialRegex = RegExp(r'[^a-zA-Z0-9#$@!%&*?]');
    if(specialRegex.hasMatch(password.value)) {
      passwordMessageStatus.value = MessageStatus.defaultMessage;
      return;
    }

    final regex = RegExp(r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[#$@!%&*?]).{8,30}$');
    if (regex.hasMatch(password.value)) {
      passwordMessageStatus.value = MessageStatus.enabled;
      return;
    }

    if (password.isEmpty) {
      passwordMessageStatus.value = MessageStatus.defaultMessage;
    } else if (password.value.length < 8 || password.value.length > 30) {
      passwordMessageStatus.value = MessageStatus.checkLength;
    } else {
      passwordMessageStatus.value = MessageStatus.defaultMessage;
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
