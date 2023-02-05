import 'dart:convert';

class ResponseWrapper {
  String? responseCode;
  String? responseMessage;
  Map<String, dynamic>? data;

  ResponseWrapper({this.responseCode, this.responseMessage, this.data});

  ResponseWrapper.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    data = json['data'];
  }
}

class ResponseConverter {
  ResponseConverter.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson() => {};
}

extension StringExtension on String {
  Map<String, dynamic>? get jsonMap {
    return ResponseWrapper.fromJson(jsonDecode(this)).data;
  }
}