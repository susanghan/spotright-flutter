class SpotResponse {
  String? address;
  int? category;
  String? city;
  String? country;
  String? fullAddress;
  double? latitude;
  double? longitude;
  int? memberSpotId;
  String? memo;
  String? province;
  int? rating;
  String? spotName;
  List<SpotPhoto>? spotPhotos;
  bool? visited;

  SpotResponse(
      {this.address,
        this.category,
        this.city,
        this.country,
        this.fullAddress,
        this.latitude,
        this.longitude,
        this.memberSpotId,
        this.memo,
        this.province,
        this.rating,
        this.spotName,
        this.spotPhotos,
        this.visited});

  SpotResponse.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    category = json['category'];
    city = json['city'];
    country = json['country'];
    fullAddress = json['fullAddress'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    memberSpotId = json['memberSpotId'];
    memo = json['memo'];
    province = json['province'];
    rating = json['rating'];
    spotName = json['spotName'];
    if (json['spotPhotos'] != null) {
      spotPhotos = <SpotPhoto>[];
      json['spotPhotos'].forEach((v) {
        spotPhotos!.add(SpotPhoto.fromJson(v));
      });
    }
    visited = json['visited'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['category'] = category;
    data['city'] = city;
    data['country'] = country;
    data['fullAddress'] = fullAddress;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['memberSpotId'] = memberSpotId;
    data['memo'] = memo;
    data['province'] = province;
    data['rating'] = rating;
    data['spotName'] = spotName;
    data['spotPhotos'] = spotPhotos?.map((v) => v.toJson()).toList() ?? [];
    data['visited'] = visited;
    return data;
  }
}

class SpotPhoto {
  String? photoUrl;
  int? spotPhotoId;

  SpotPhoto({this.photoUrl, this.spotPhotoId});

  SpotPhoto.fromJson(Map<String, dynamic> json) {
    photoUrl = json['photoUrl'];
    spotPhotoId = json['spotPhotoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['photoUrl'] = photoUrl;
    data['spotPhotoId'] = spotPhotoId;
    return data;
  }
}