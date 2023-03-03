import 'dart:ui';

import 'package:get/get.dart';
import 'package:spotright/data/local/local_repository.dart';

class ChangeUserLanguageController extends GetxController {
  LocalRepository localRepository = Get.find();
  final String languageKey = "language";
  Function()? reRender;

  void initState(Function() reRender) {
    this.reRender = reRender;
  }

  void changeLanguage(Locale locale) {
    Get.locale = locale;
    localRepository.save(languageKey, locale.languageCode);
    reRender?.call();
  }
}