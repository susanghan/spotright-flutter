import 'package:flutter/material.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: DefaultAppBar(title: '', hasBackButton: true,)
    ));
  }
}
