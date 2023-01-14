import 'package:flutter/material.dart';
import 'package:spotright/presentation/component/sr_appbar/default_app_bar.dart';
import 'package:spotright/presentation/component/sr_cta_button/sr_cta_button.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';

class AddSpot extends StatefulWidget {
  const AddSpot({Key? key}) : super(key: key);

  @override
  State<AddSpot> createState() => _AddSpotState();
}

class _AddSpotState extends State<AddSpot> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: DefaultAppBar(
            title: "장소추가",
            hasBackButton: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("장소명을 입력해주세요."),
                SrTextField(),
                Text("주소를 입력해주세요."),
                SrTextField(),
                Text("카테고리를 입력햇주세요."),
                Text("메모"),
                SrTextField(),
                Text("120/140"),
                Text("방문한 장소인가요?"),
                Text("사진 첨부"),
                SrCTAButton(
                  text: "완료",
                  action: () {  },)
              ],
            ),
          ),
        ));
  }
}
