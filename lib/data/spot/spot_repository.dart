import 'package:get/get.dart';
import 'package:spotright/common/network_client.dart';
import 'package:spotright/data/model/response_wrapper.dart';
import 'package:spotright/data/spot/location_request.dart';
import 'package:spotright/data/spot/location_response.dart';
import 'package:spotright/data/spot/spot_request.dart';
import 'package:spotright/data/spot/spot_response.dart';

class SpotRepository {
  final String findOneSpotPath = "/member";
  final String getSpotsByCoordinatePath = "/member";
  final String saveSpotPath = "/member/spot";
  final String deleteSpotPath = "/member";
  final String searchSpotByCoordinatePath = "/member/spot/coordinate";
  final String searchSpotPath = "/member/spot/search";
  final String updateSpotPath = "/member/spot/update";
  final String _deleteSpotsPath = "/member/spot";

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

  Future<SpotResponse> saveSpot(SpotRequest spotRequest) async {
    var res = await networkClient.request(method: Http.post, body: spotRequest.toJson(), path: saveSpotPath);
    return SpotResponse.fromJson(res.jsonMap!);
  }

  Future<void> deleteSpot(int memberSpotId) async {
    await networkClient.request(method: Http.delete, path: "$deleteSpotPath/$memberSpotId");
  }

  Future<void> deleteSpots(List<int> memberSpotIds) async {
    await networkClient.request(method: Http.delete, path: _deleteSpotsPath, body: {"deleteMemberSpotIds": memberSpotIds});
  }

  Future<void> searchSpotByCoordinate(SpotRequest spotRequest) async {
    await networkClient.request(method: Http.post, body: spotRequest.toJson(), path: searchSpotByCoordinatePath);
  }

  Future<List<LocationResponse>> searchSpot(LocationRequest locationRequest) async {
    var res = await networkClient.request(method: Http.post, body: locationRequest.toJson() ,path: searchSpotPath);
    if(res.responseWrapper.responseCode == "SPOT_NOT_FOUND") return [LocationResponse(fullAddress: "검색어를 수정해서 다시 검색해 주세요", name: "검색 결과 없음", address: "검색 결과 없음", city: "검색 결과 없음")];
    return res.list?.map((spot) =>  LocationResponse.fromJson(spot)).toList() ?? [];
  }

  Future<SpotResponse> updateSpot(SpotRequest spotRequest) async {
    var res = await networkClient.request(method: Http.post, body: spotRequest.toJson(),path: updateSpotPath);
    return SpotResponse.fromJson(res.jsonMap!);
  }
}