import 'package:flutter/material.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';

class BlockList extends StatefulWidget {
  const BlockList({Key? key}) : super(key: key);

  @override
  State<BlockList> createState() => _BlockListState();
}

class _BlockListState extends State<BlockList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: DefaultAppBar(title: "차단 사용자 목록", hasBackButton: true,),
    ),);
  }
}
