import 'package:get/get.dart';
import 'package:spotright/presentation/page/following/following_state.dart';

class FollowingController extends GetxController {

  FollowingController({required this.followingState});

  final FollowingState followingState;

  void changeTab(int index) {
    followingState.tabIndex.value = index;
  }
}