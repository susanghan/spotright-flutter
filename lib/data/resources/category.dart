import 'dart:ui';

import '../../presentation/common/colors.dart';

class Category{
  static List<String> mainCategory = ["식당", "카페", "관광지", "숙소", "쇼핑", "병원", "기타"];
  static List<Color> mainCategoryColors = [SrColors.restaurant, SrColors.cafe, SrColors.tour, SrColors.accommodation, SrColors.shopping, SrColors.hospital, SrColors.etc];

  //["식당", "카페", "관광지", "숙소", "쇼핑", "병원", "기타"] 순서.
  static Map<int, List<String>> subCategories = {
    1: ["선택 없음", "아시안", "패스트푸드", "양식", "브런치", "멕시칸", "중식", "일식", "한식", "건강식"],
    2: ["선택 없음"],
    3: ["선택 없음", "시장", "공원", "테마파크", "박물관", "역사", "스트릿"],
    4: ["선택 없음", "호텔&리조트", "모텔", "펜션&풀빌라", "에어비앤비", "캠핑&글램핑", "게스트하우스"],
    5: ["선택 없음"],
    6: ["선택 없음"],
    7: ["선택 없음"],
  };

  //subCategory 사용 방법
  //List<String>? subCategory = subCategories[1]; => 대분류에 의해 선택된 소분류 리스트
  //String selected = subCategory![3]; => 실제로 선택된 소분류 => 들어온 코드의 [1,3] 자리 수 사용
  //"대분류 selectedIndex" + "소분류 selectedIndex" .toInt() => 서버한테 줄 때




}