import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';

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
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: SrColors.black,),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: SrColors.white,
          title: Text('검색', style: TextStyle(color: SrColors.black),),
          centerTitle: true,
        ),
      ),
    );
  }
}
