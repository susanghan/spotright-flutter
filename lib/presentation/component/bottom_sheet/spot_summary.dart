class SpotSummary {
  SpotSummary({this.title = "", this.category = "", this.address = "", this.memo, this.photoUrl, this.rating});

  final String title;
  final String category;
  final String address;
  final String? memo;
  final String? photoUrl;
  final int? rating;
}