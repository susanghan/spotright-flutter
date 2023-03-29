import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:logger/logger.dart';
import 'package:spotright/common/network_client.dart';
import 'package:spotright/data/email/email_repository.dart';
import 'package:spotright/data/file/file_repository.dart';
import 'package:spotright/data/oauth/oauth_repository.dart';
import 'package:spotright/data/local/local_repository.dart';
import 'package:spotright/data/report/report_repository.dart';
import 'package:spotright/data/spot/spot_repository.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/version/version.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/controller/navigation_controller.dart';
import 'package:spotright/presentation/common/language.dart';
import 'package:spotright/presentation/page/block_list/block_list.dart';
import 'package:spotright/presentation/page/congratulation/congratulation.dart';
import 'package:spotright/presentation/page/detail/detail_controller.dart';
import 'package:spotright/presentation/page/edit_profile/edit_profile.dart';
import 'package:spotright/presentation/page/home/home.dart';
import 'package:spotright/presentation/page/home/home_controller.dart';
import 'package:spotright/presentation/page/login/Login.dart';
import 'package:spotright/presentation/page/login/user_controller.dart';
import 'package:spotright/presentation/page/register_spot/register_spot_controller.dart';
import 'package:spotright/presentation/page/search_location/search_location.dart';
import 'package:spotright/presentation/page/search_location/search_location_controller.dart';
import 'package:spotright/presentation/page/signup/sign_up.dart';
import 'package:spotright/presentation/page/splash/splash.dart';


void main() async {
  runApp(Spotright());
  Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  String kakaoLoginKey = dotenv.env['KAKAO_LOGIN_KEY'] ?? '';
  KakaoSdk.init(nativeAppKey: kakaoLoginKey);
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
        '/block_list': (context) => const BlockList(),
        '/edit_profile': (context) => const EditProfile(),
        '/login': (context) => const Login(),
        '/congratulation': (context) => const Congratulation(),
        '/searchLocation': (context) => const SearchLocation(),
        '/splash': (context) => const Splash(),
      },
      theme: ThemeData(
        primarySwatch: SrColors.materialPrimary,
        canvasColor: SrColors.white,
        fontFamily: 'Pretendard'
      ),
      initialRoute: '/splash',
      initialBinding: BindingsBuilder(() {
        // 순서 중요
        Get.put(Logger());

        Get.put(NetworkClient());

        Get.put(LocalRepository());
        Get.put(UserRepository());
        Get.put(OAuthRepository());
        Get.put(SpotRepository());
        Get.put(ReportRepository());
        Get.put(EmailRepository());
        Get.put(FileRepository());

        Get.put(NavigationController());
        Get.put(DetailController());
        Get.put(UserController());
        Get.put(HomeController());
        Get.put(SearchLocationController());
        Get.put(RegisterSpotController());
      }),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      translations: Languages(),
    );
  }

  @override
  void initState() {

    VersionRepository().checkAppVersion();

    initLocale();
    super.initState();
  }

  Future<void> initLocale() async {
    final String languageKey = "language";
    String savedLanguage = await LocalRepository().fetch(languageKey);
    Locale locale = Get.deviceLocale ?? const Locale('ko', 'KR');

    if(savedLanguage.isNotEmpty) {
      switch (savedLanguage) {
        case 'ko':
          locale = const Locale('ko', 'KR');
          break;
        case 'en':
          locale = const Locale('en', 'US');
          break;
        default:
          locale = const Locale('ko', 'KR');
      }
    }

    Get.locale = locale;
  }
}
