import 'package:get/get.dart';

class NavigationController extends GetxController {
  Function() navigatePage(dynamic page, Function() initState) => () => Get.to(page)?.then((_) => initState());
}