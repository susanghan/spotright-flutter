import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/colors.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: SrColors.black,),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: SrColors.white,
          title: Text('마이페이지', style: TextStyle(color: SrColors.black),),
          centerTitle: true,
        ),
      ),
    );
  }
}
