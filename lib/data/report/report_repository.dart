import 'package:get/get.dart';
import 'package:spotright/common/network_client.dart';
import 'package:spotright/data/report/report_request.dart';

class ReportRepository {
  final String reportPath = "/member/report";

  NetworkClient networkClient = Get.find();

  Future<void> report(ReportRequest request) async {
    await networkClient.request(method: Http.post, path: reportPath, body: request.toJson());
  }
}