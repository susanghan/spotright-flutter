import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
                  padding: EdgeInsets.only(bottom: 20),
                  child: SrTextField(
                    hint: "아이디로 사용자를 검색하세요.",
                    suffixIcon: SvgPicture.asset(
                      "assets/search.svg",
                      color: SrColors.primary,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 14), child: Text("최근 검색어")),
                Column(
                  children: [1, 2, 3].map((e) => _Profile()).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _Profile() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Row(children: [
        Container(
          width: 60,
          height: 60,
          margin: EdgeInsets.only(right: 16),
          child: CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage("https://picsum.photos/180")),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ghdrlfehd"),
            Text("홍길동"),
          ],
        ),
        Spacer(),
        SvgPicture.asset("assets/delete.svg", color: SrColors.gray1,)
      ]),
    );
  }
}
