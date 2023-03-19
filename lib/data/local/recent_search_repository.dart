import 'dart:convert';

import 'package:get/get.dart';
import 'package:spotright/data/local/local_repository.dart';
import 'package:spotright/data/model/response_wrapper.dart';
import 'package:spotright/data/user/user_response.dart';

class RecentSearchRepository {
  final String key = "recentSearch";
  final LocalRepository localRepository = LocalRepository();
  final numberOfData = 20;

  void saveSearch(UserResponse searchData) async {
    List<UserResponse> savedData = await getRecentSearch();

    // 중복 제거
    savedData.remove(savedData
        .firstWhereOrNull((user) => user.memberId == searchData.memberId));
    savedData.insert(0, searchData);

    if (savedData.length > numberOfData) {
      savedData.removeLast();
    }

    localRepository.save(key, jsonEncode(savedData));
  }

  Future<List<UserResponse>> getRecentSearch() async {
    String jsonString = await localRepository.fetch(key);
    if(jsonString.isEmpty) jsonString = "[]";
    return (jsonDecode(jsonString) as List<dynamic>).map((e) => UserResponse.fromJson(e)).toList();
  }

  Future<List<UserResponse>> removeRecent(UserResponse user) async {
    List<UserResponse> savedData = await getRecentSearch();

    savedData.remove(savedData
        .firstWhereOrNull((savedUser) => savedUser.memberId == user.memberId));

    localRepository.save(key, jsonEncode(savedData));

    return await getRecentSearch();
  }
}
