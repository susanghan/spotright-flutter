import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/page/home/home.dart';
import 'package:spotright/presentation/page/signup/sign_up.dart';
import 'package:spotright/presentation/page/signup/sign_up_controller.dart';
import 'package:spotright/presentation/page/signup/sign_up_state.dart';

void main() {
  runApp(const Spotright());
}

class Spotright extends StatelessWidget {
  const Spotright({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Spotright',
      routes: {
        '/home': (context) => const Home(),
        '/signup': (context) => const SignUp(),
      },
      theme: ThemeData(
        primarySwatch: SrColors.materialPrimary,
      ),
      initialRoute: '/home',
      initialBinding: BindingsBuilder(() {
        Get.put(SignUpController(signUpState: SignUpState()));
      }),
    );
  }
}
