class LocationRequest {
  String? country;
  double? latitude;
  double? longitude;
  String? queryType;
  String? searchQuery;

  LocationRequest(
      {
        this.country,
        this.latitude,
        this.longitude,
        this.queryType,
        this.searchQuery});

  LocationRequest.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    queryType = json['queryType'];
    searchQuery = json['searchQuery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['queryType'] = queryType;
    data['searchQuery'] = searchQuery;
    return data;
  }
}