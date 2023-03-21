import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:spotright/common/token_util.dart';
import 'package:spotright/data/local/local_repository.dart';
import 'package:spotright/data/model/response_wrapper.dart';
import 'package:spotright/env/server_env.dart';
import 'package:spotright/presentation/page/inspection/inspection.dart';

class NetworkClient {
  Logger logger = getx.Get.find();
  LocalRepository localRepository = LocalRepository();
  String baseUrl = ServerEnv.baseUrl;
  String prefix = "/api";
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
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    if((refreshToken?.isNotEmpty ?? false) && accessToken.isNotEmpty) await verifyAndRefreshToken();

    headers ??= {};
    headers["content-type"] = "application/json";
    headers["accept"] = "*/*";
    headers["authorization"] = headers["authorization"] ?? accessToken;

    return _requestWithLog(method: method, path: path, headers: headers, body: body, queryParameters: queryParameters);
  }

  Future<Response> _requestWithLog({
    Http method = Http.get,
    required String path,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    path = prefix + path;

    var url = Uri.https(baseUrl, path, queryParameters);
    Function func = method.function;

    logger.log(
        Level.debug, "$method : $path <<< headers : $headers <<< parameters : $queryParameters <<< body : $body");
    Response response = (body == null)
        ? await func.call(url, headers: headers)
        : await func.call(url, headers: headers, body: jsonEncode(body));
    logger.d("$method : $path \x1B[33m${response.statusCode}\x1B[0m "
        ">>> headers : ${response.headers} ");
    if(response.body.isNotEmpty) debugPrint(">>> body : ${jsonDecode(utf8.decode(response.bodyBytes))}"
        , wrapWidth: 1024);
    
    if(response.statusCode == 503) {
      getx.Get.to(Inspection());
    }

    return response;
  }

  Future<Response> login({
    Http method = Http.get,
    required String path,
    required Map<String, String> headers,
  }) async {

    var res = await _requestWithLog(method: method, path: path, headers: headers);
    Map<String, String>? resHeaders = res.headers;

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
