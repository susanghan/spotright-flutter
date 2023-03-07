import 'package:flutter/material.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';

class Email extends StatefulWidget {
  const Email({Key? key}) : super(key: key);

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: DefaultAppBar(title: "이메일 인증", hasBackButton: true,),
    ));
  }
}
