import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/language.dart';
import 'package:spotright/presentation/page/block_list/block_list.dart';
import 'package:spotright/presentation/page/detail/detail.dart';
import 'package:spotright/presentation/page/edit_profile/efit_profile.dart';
import 'package:spotright/presentation/page/following/following.dart';
import 'package:spotright/presentation/page/home/home.dart';
import 'package:spotright/presentation/page/my_page/my_page.dart';
import 'package:spotright/presentation/page/search/search.dart';
import 'package:spotright/presentation/page/signup/sign_up.dart';
import 'package:spotright/presentation/page/signup/sign_up_controller.dart';
import 'package:spotright/presentation/page/signup/sign_up_state.dart';
import 'package:spotright/presentation/page/spot_list/spot_list.dart';

void main() {
  runApp(Spotright());
}

class Spotright extends StatefulWidget {
  const Spotright({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<Spotright> {



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Spotright',
      routes: {
        '/home': (context) => const Home(),
        '/signup': (context) => const SignUp(),
        '/detail': (context) => const Detail(),
        '/block_list': (context) => const BlockList(),
        '/edit_profile': (context) => const EditProfile(),
        '/following': (context) => const Following(),
        '/spot_list': (context) => const SpotList(),
      },
      theme: ThemeData(
        primarySwatch: SrColors.materialPrimary,
      ),
      initialRoute: '/signup',
      initialBinding: BindingsBuilder(() {
        Get.put(SignUpController(signUpState: SignUpState()));
      }),
      locale: Get.locale,
      fallbackLocale: const Locale('en', 'US'),
      translations: Languages(),
    );
  }

  @override
  void initState() {
    super.initState();
    Get.locale = const Locale('en', 'US');
  }
}
