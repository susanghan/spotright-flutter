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

  Future<bool> verifyEmail(String email, String code) async {
    var res = await networkClient.request(method: Http.patch, path: _verifyEmailPath, body: {
      "email": email,
      "verificationCode": code,
    });

    return res.statusCode == 200;
  }
}