import 'package:get/get.dart';
import 'package:spotright/common/network_client.dart';

class FileRepository {
  final String postProfileFilePath = "/member/file";
  final String postSpotFilePath = "/member/spot/files";

  NetworkClient networkClient = Get.find();

  Future<void> postProfileFile() async {
    await networkClient.request(path: postProfileFilePath);
  }

  Future<void> postSpotFile() async {
    await networkClient.request(path: postSpotFilePath);
  }
}