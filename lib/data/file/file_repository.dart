import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetX;
import 'package:spotright/common/network_client.dart';
import 'package:http_parser/http_parser.dart';

//프로필 이미지나, 스팟 이미지 파일 업로드 할 때 사용하는 것
class FileRepository {
  Dio dio = Dio();
  final String _postProfileFilePath = "/member/photo";
  final String _postSpotFilePath = "/member/spot/files";

  NetworkClient networkClient = GetX.Get.find();

  Future<bool> postProfileFile(String? photoPath) async {
    if(photoPath == null) {
      networkClient.request(method: Http.post, path: _postProfileFilePath, body: {'photo': null});
    }

    FormData formData = FormData.fromMap({'photo': MultipartFile.fromFileSync(photoPath!, contentType: MediaType("image", "jpeg"))});
    return uploadImage(formData, _postProfileFilePath);
  }

  Future<bool> uploadSpotImages(List<String> photoPaths, int spotId) async {
    List<MultipartFile> files = photoPaths.map((photoPath) => MultipartFile.fromFileSync(photoPath, contentType: MediaType("image", "jpeg"))).toList();
    FormData formData = FormData.fromMap({'photos': files, 'memberSpotId': spotId});
    return uploadImage(formData, _postSpotFilePath);
  }

  Future<bool> uploadImage(FormData formData, String path) async {
    dio.options.headers = {"authorization": networkClient.accessToken};
    dio.options.contentType = 'multipart/form-data';
    var response = await dio.post("https://${networkClient.baseUrl}${networkClient.prefix}$path", data: formData);
    return (response.statusCode! / 100) == 2;
  }
}