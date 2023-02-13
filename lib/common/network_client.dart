import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:spotright/common/token_util.dart';
import 'package:spotright/data/local/local_repository.dart';
import 'package:spotright/data/model/response_wrapper.dart';

class NetworkClient {
  Logger logger = getx.Get.find();
  LocalRepository localRepository = LocalRepository();
  String baseUrl = "spotright-dev.nogamsung.com";
  String prefix = "/api/v1";
  String accessToken = "";
  String? refreshToken;
  final String refreshTokenKey = "refreshToken";
  final String refreshTokenPath = "/member/token/renew";

  /**
   * 사용 예시 : networkClient.request(method: Http.get, path: "member/article?page=1")
   */
  Future<Response> request({
    Http method = Http.get,
    required String path,
    Map<String, String>? headers,
    String? body
  }) async {
    if(refreshToken?.isNotEmpty ?? false) await verifyAndRefreshToken();

    headers ??= {};
    headers["authorization"] = headers["authorization"] ?? accessToken;

    return _requestWithLog(method: method, path: path, headers: headers, body: body);
  }

  Future<Response> _requestWithLog({
    Http method = Http.get,
    required String path,
    Map<String, String>? headers,
    String? body,
  }) async {
    path = prefix + path;

    var url = Uri.https(baseUrl, path);
    Function func = method.function;

    logger.log(
        Level.debug, "$method : $path <<< headers : $headers <<< body : $body");
    Response response = (body == null)
        ? await func.call(url, headers: headers)
        : await func.call(url, headers: headers, body: body);
    debugPrint("$method : $path \x1B[33m${response.statusCode}\x1B[0m "
        ">>> headers : ${response.headers} "
        ">>> body : ${jsonDecode(utf8.decode(response.bodyBytes))}"
        , wrapWidth: 1024);

    return response;
  }

  Future<Response> login({
    Http method = Http.get,
    required String path,
    required Map<String, String> headers,
  }) async {

    var res = await _requestWithLog(method: method, path: path, headers: headers);
    Map<String, String>? resHeaders = res.headers;

    print("왜지 ${res.responseWrapper.responseCode}");
    if(res.responseWrapper.responseCode == "MEMBER_LOGIN") saveRefreshToken(resHeaders);

    return res;
  }

  Future<void> refreshLogin() async {
    if(refreshToken == null && refreshToken!.isEmpty) return;

    Map<String, String> requestHeader = {"authorization": refreshToken!};
    var res = await _requestWithLog(path: refreshTokenPath, headers: requestHeader);
    Map<String, String> headers = res.headers;
    saveRefreshToken(headers);
  }

  void saveRefreshToken(Map<String, String> headers) {
    String? auth = headers["authorization"];

    // todo : 실패 케이스 처리
    if(auth == null) return;

    TokenUtil tokenUtil = TokenUtil();
    List<String> tokens = tokenUtil.getTokens(auth);
    accessToken = tokens[0];
    refreshToken = tokens[1];

    localRepository.save(refreshTokenKey, refreshToken!);
  }

  Future<void> verifyAndRefreshToken() async {
    TokenUtil tokenUtil = TokenUtil();

    if(!tokenUtil.isValidToken(token: accessToken)) await refreshLogin();
  }
}

extension HttpExtention on Http {
  Function get function {
    switch (this) {
      case Http.get:
        return get;
      case Http.post:
        return post;
      case Http.put:
        return put;
      case Http.delete:
        return delete;
      case Http.patch:
        return patch;
      default:
        return get;
    }
  }
}

enum Http { get, post, put, delete, patch }
