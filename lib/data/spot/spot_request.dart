class SpotRequest {
  String? address;
  int? category;
  String? city;
  String? country;
  List<int>? deleteSpotPhotoIds; // update only
  double? latitude;
  double? longitude;
  int? memberSpotId; // update only
  String? memo;
  String? province;
  String? rating;
  String? spotName;
  String? queryType;
  String? searchQuery;

  SpotRequest(
      {this.address,
        this.category,
        this.city,
        this.country,
        this.deleteSpotPhotoIds,
        this.latitude,
        this.longitude,
        this.memberSpotId,
        this.memo,
        this.province,
        this.rating,
        this.spotName,
        this.queryType,
        this.searchQuery});

  SpotRequest.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    category = json['category'];
    city = json['city'];
    country = json['country'];
    deleteSpotPhotoIds = json['deleteSpotPhotoIds'].cast<int>();
    latitude = json['latitude'];
    longitude = json['longitude'];
    memberSpotId = json['memberSpotId'];
    memo = json['memo'];
    province = json['province'];
    rating = json['rating'];
    spotName = json['spotName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['category'] = category;
    data['city'] = city;
    data['country'] = country;
    data['deleteSpotPhotoIds'] = deleteSpotPhotoIds;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['memberSpotId'] = memberSpotId;
    data['memo'] = memo;
    data['province'] = province;
    data['rating'] = rating;
    data['spotName'] = spotName;
    data['queryType'] = queryType;
    data['searchQuery'] = searchQuery;
    return data;
  }
}