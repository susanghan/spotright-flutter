import 'dart:convert';

import 'package:spotright/data/repository/local_repository.dart';

class RecentSearchRepository {
  final String key = "recentSearch";
  final LocalRepository localRepository = LocalRepository();
  final numberOfData = 20;

  // todo : 나중에 String이 아니라 data model로 바뀌어야 함.
  void saveSearch(String searchData) async {
    List<String> savedData = await getRecentSearch();

    // 중복 제거
    savedData.remove(searchData);
    savedData.insert(0, searchData);

    if(savedData.length > numberOfData) {
      savedData.removeLast();
    }

    localRepository.save(key, savedData.toString());
  }

  Future<List<String>> getRecentSearch() async {
    String jsonString = await localRepository.fetch(key);
    return (jsonDecode(jsonString) as List<dynamic>).cast<String>();
  }
}