import 'package:get/get.dart';
import 'package:spotright/common/network_client.dart';

class SpotRepository {
  final String findOneSpotPath = "/member";
  final String getSpotsByCoordinatePath = "/member";
  final String saveSpotPath = "/member/spot";
  final String deleteSpotPath = "/member";
  final String searchSpotByCoordinatePath = "/member/coordinate";
  final String searchSpotByAddressPath = "/member/spot/search";
  final String updateSpotPath = "/member/spot/update";

  NetworkClient networkClient = Get.find();

  Future<void> findOneSpot(int memberId, int memberSpotId) async {
    await networkClient.request(path: "$findOneSpotPath/$memberId/spot/$memberSpotId");
  }

  Future<void> getSpotsFromCoordinate(int memberId, double topLongitude, double topLatitude, double bottomLongitude, double bottomLatitude) async {
    await networkClient.request(path: "$getSpotsByCoordinatePath/$memberId/spots/$topLongitude/$topLatitude/$bottomLongitude/$bottomLatitude");
  }

  Future<void> saveSpot() async {
    await networkClient.request(method: Http.post, path: saveSpotPath);
  }

  Future<void> deleteSpot(int memberSpotId) async {
    await networkClient.request(method: Http.delete, path: "$deleteSpotPath/$memberSpotId");
  }

  Future<void> searchSpotByCoordinate() async {
    await networkClient.request(method: Http.post, path: searchSpotByCoordinatePath);
  }

  Future<void> searchSpotByAddress() async {
    await networkClient.request(method: Http.post, path: searchSpotByAddressPath);
  }

  Future<void> updateSpot() async {
    await networkClient.request(method: Http.post, path: updateSpotPath);
  }
}