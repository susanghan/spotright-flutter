class SrAppBarModel {
  SrAppBarModel({this.userName = '', this.spots = 0, this.followers = 0, this.followings = 0});

  String userName;
  int spots;
  int followers;
  int followings;
  List<int> selectedChips = [0, 1, 2, 3, 4, 5, 6, 7];
}