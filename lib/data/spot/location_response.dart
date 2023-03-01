class LocationResponse {
  String? province;
  String? address;
  String? city;
  String? fullAddress;
  double? latitude;
  double? longitude;
  String? name;

  LocationResponse(
      {this.province,
        this.address,
        this.city,
        this.fullAddress,
        this.latitude,
        this.longitude,
        this.name});

  LocationResponse.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    province = json['province'];
    city = json['city'];
    name = json['name'];
    fullAddress = json['fullAddress'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['province'] = province;
    data['city'] = city;
    data['name'] = name;
    data['fullAddress'] = fullAddress;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
