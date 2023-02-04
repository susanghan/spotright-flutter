class ResponseWrapper<T extends ResponseConverter> {
  String? responseCode;
  String? responseMessage;
  ResponseConverter? data;

  ResponseWrapper({this.responseCode, this.responseMessage, this.data});

  ResponseWrapper.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    data = json['data'] != null ? ResponseConverter.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ResponseConverter {
  ResponseConverter.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson() => {};
}