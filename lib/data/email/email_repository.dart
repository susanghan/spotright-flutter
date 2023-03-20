import 'package:get/get.dart';

import '../../common/network_client.dart';

class EmailRepository {
  NetworkClient networkClient = Get.find();

  final String _sendMailPath = "/member/email";
  final String _verifyEmailPath = "/member/email";

  Future<void> sendMail(String email) async {
    await networkClient.request(method: Http.post, path: _sendMailPath, body: {
      "email": email,
      "language": "KR"
    });
  }

  Future<String> verifyEmail(String email, String code) async {
    var res = await networkClient.request(method: Http.patch, path: _verifyEmailPath, body: {
      "email": email,
      "verificationCode": code,
    });

    if(res.statusCode == 200) {
      String strangeAccessToken = res.headers['authorization']!.split(':')[1].removeAllWhitespace;
      return strangeAccessToken.substring(0, strangeAccessToken.length - 1);
    } else {
      return '';
    }
  }
}