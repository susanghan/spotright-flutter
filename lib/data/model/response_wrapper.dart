import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';

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

extension Uint8ListExtension on Uint8List {
  Map<String, dynamic>? get jsonMap {
    return ResponseWrapper.fromJson(jsonDecode(utf8.decode(this))).data;
  }
}

extension ResponseExtension on Response {
  Map<String, dynamic>? get jsonMap {
    return ResponseWrapper.fromJson(jsonDecode(utf8.decode(bodyBytes))).data;
  }
}