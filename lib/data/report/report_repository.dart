import 'package:get/get.dart';
import 'package:spotright/common/network_client.dart';

class ReportRepository {
  final String reportPath = "/member/report";

  NetworkClient networkClient = Get.find();

  Future<void> report() async {
    await networkClient.request(path: reportPath);
  }
}