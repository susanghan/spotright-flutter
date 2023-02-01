import 'package:flutter/material.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: const DefaultAppBar(title: "프로필 수정", hasBackButton: true,),
          body: Container(),
        )
    );
  }
}
