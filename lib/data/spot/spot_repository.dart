import 'package:get/get.dart';
import 'package:spotright/common/network_client.dart';
import 'package:spotright/data/model/response_wrapper.dart';
import 'package:spotright/data/spot/spot_request.dart';
import 'package:spotright/data/spot/spot_response.dart';

class SpotRepository {
  final String findOneSpotPath = "/member";
  final String getSpotsByCoordinatePath = "/member";
  final String saveSpotPath = "/member/spot";
  final String deleteSpotPath = "/member";
  final String searchSpotByCoordinatePath = "/member/spot/coordinate";
  final String searchSpotByAddressPath = "/member/spot/search";
  final String updateSpotPath = "/member/spot/update";

  NetworkClient networkClient = Get.find();

  Future<SpotResponse> findOneSpot(int memberId, int memberSpotId) async {
    var res = await networkClient.request(path: "$findOneSpotPath/$memberId/spot/$memberSpotId");
    return SpotResponse.fromJson(res.jsonMap!);
  }

  /**
   * 위도 : latitude, 경도 : longitude
   * 아마도 전체 범위 : top (90, -180) - bottom (0, 180)
   */
  Future<List<SpotResponse>> getSpotsFromCoordinate(int memberId, {double topLongitude = -180, double topLatitude = 90, double bottomLongitude = 179.999999, double bottomLatitude = 0}) async {
    var res = await networkClient.request(path: "$getSpotsByCoordinatePath/$memberId/spots/$topLongitude/$topLatitude/$bottomLongitude/$bottomLatitude");
    return res.list?.map((spot) => SpotResponse.fromJson(spot)).toList() ?? [];
  }

  Future<void> saveSpot() async {
    await networkClient.request(method: Http.post, path: saveSpotPath);
  }

  Future<void> deleteSpot(int memberSpotId) async {
    await networkClient.request(method: Http.delete, path: "$deleteSpotPath/$memberSpotId");
  }

  Future<void> deleteSpots(List<int> memberSpotIds) async {
    // todo: 스팟 일괄 삭제 api 연결
  }

  Future<void> searchSpotByCoordinate(SpotRequest spotRequest, {String queryType = "ADDRESS", String searchQuery = "null"}) async {
    await networkClient.request(method: Http.post, body: spotRequest.toJson(), path: searchSpotByCoordinatePath);
  }

  Future<void> searchSpotByAddress() async {
    await networkClient.request(method: Http.post, path: searchSpotByAddressPath);
  }

  Future<void> updateSpot() async {
    await networkClient.request(method: Http.post, path: updateSpotPath);
  }
}