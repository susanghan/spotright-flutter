import 'package:get/get.dart';
import 'package:spotright/common/network_client.dart';

//프로필 이미지나, 스팟 이미지 파일 업로드 할 때 사용하는 것

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