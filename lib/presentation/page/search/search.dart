import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotright/data/user/user_response.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';
import 'package:spotright/presentation/page/profile/profile.dart';
import 'package:spotright/presentation/page/search/search_controller.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  SearchController searchController = Get.put(SearchController());

  @override
  void initState() {
    searchController.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
          title: "검색",
          hasBackButton: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: SrTextField(
                    focusInputBorder: const OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(22)),
                        borderSide: BorderSide(width: 1, color: SrColors.gray2)),
                    onChanged: searchController.onChangeSearchText,
                    onSubmitted: (text){searchController.search();},
                    hint: "아이디로 사용자를 검색하세요.",
                    suffixIcon: GestureDetector(
                      onTap: searchController.search,
                      child: SvgPicture.asset(
                        "assets/search.svg",
                        color: SrColors.primary,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
                Obx(() => Column(
                      children: searchController.users.value
                          .map((user) => _Profile(user))
                          .toList(),
                    )),
                Padding(
                    padding: EdgeInsets.only( bottom: 14),
                    child: Text("최근 검색", style: SrTypography.body2semi,)),
                Obx(() => Column(
                  children: searchController.recentUsers.value
                      .map((user) => _Profile(user, isRecentSearch: true))
                      .toList(),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _Profile(UserResponse user, {bool isRecentSearch = false}) {
    return GestureDetector(
      onTap: () {
        Get.to(Profile(user: user));
        searchController.saveRecentSearch(user);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Row(children: [
          Container(
            width: 60,
            height: 60,
            margin: EdgeInsets.only(right: 16),
            child: ProfilePhoto(user.memberPhoto?.photoUrl),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.spotrightId ?? "UNKNOWN"),
              Text(user.nickname ?? "UNKNOWN"),
            ],
          ),
          Spacer(),
          if (isRecentSearch)
            GestureDetector(
              onTap: () {
                searchController.removeRecentSearch(user);
              },
              child: SvgPicture.asset(
                "assets/delete.svg",
                color: SrColors.gray1,
              ),
            )
        ]),
      ),
    );
  }

  Widget ProfilePhoto(String? photoUrl) {
    if (photoUrl == null)
      return Image(image: AssetImage("assets/user_profile_default_small.png"));

    return CircleAvatar(
        backgroundColor: SrColors.white,
        radius: 100,
        backgroundImage: NetworkImage(photoUrl));
  }
}
