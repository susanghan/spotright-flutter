import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetX;
import 'package:spotright/common/network_client.dart';
import 'package:http_parser/http_parser.dart';

//프로필 이미지나, 스팟 이미지 파일 업로드 할 때 사용하는 것
class FileRepository {
  final String _postProfileFilePath = "/member/photo";
  final String _postSpotFilePath = "/member/spot/files";

  NetworkClient networkClient = GetX.Get.find();

  Future<bool> postProfileFile(String? photoPath) async {
    if(photoPath == null) {
      networkClient.request(method: Http.post, path: _postProfileFilePath, body: {'photo': null});
    }

    FormData formData = FormData.fromMap({'photo': MultipartFile.fromFileSync(photoPath!, contentType: MediaType("image", "jpeg"))});
    return await updateUserProfile(formData);
  }

  Future<void> postSpotFile() async {
    await networkClient.request(method: Http.post, path: _postSpotFilePath);
  }

  Future<bool> updateUserProfile(FormData formData) async {
    var dio = Dio();
    dio.options.headers = {"authorization": networkClient.accessToken};
    dio.options.contentType = 'multipart/form-data';
    var response = await dio.post("https://${networkClient.baseUrl}${networkClient.prefix}$_postProfileFilePath", data: formData);
    return (response.statusCode! / 100) == 2;
  }
}