class SrAppBarModel {
  SrAppBarModel({this.userName = '', this.spots = 0, this.followers = 0, this.followings = 0});

  String userName;
  int spots;
  int followers;
  int followings;
  List<bool> selectedChips = [true, false, false, false, false, false, false, false];
}