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

  var idMessageStatus = MessageStatus.defaultMessage.obs;
  UserRepository userRepository = Get.find();
  RxBool ctaActive = false.obs;
  RxString newId = "".obs;

  Future<void> verifyId() async {
    ctaActive.value = await userRepository.verifyDuplicatedId(newId.value);
  }

  void onChangeText(String text) {
    newId.value = text;
    ctaActive.value = false;
  }
}