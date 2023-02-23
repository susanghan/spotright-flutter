class SrMarker {
  // 식당, 카페, 관광, 숙소, 쇼핑, 병원, 기타
  static List<String> categories = ['restaurant', 'cafe', 'tour', 'lodging', 'shopping', 'hospital', 'etc'];

  static List<String> markerAssets = categories.map((it) => 'assets/marker_$it.png').toList();
  static List<String> pinAssets = categories.map((it) => 'assets/pin_$it.png').toList();
}