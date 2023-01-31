import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkClient {
  Logger logger = Logger();
  String baseUrl = "spotright-dev.nogamsung.com";

  /**
   * 사용 예시 : networkClient.request(method: Http.get, path: "member/article?page=1")
   */
  Future<Response> request({
    Http method = Http.get,
    required String path,
    Map<String, String>? headers,
    String? body,
  }) async {
    var url = Uri.https(baseUrl, path);
    Function func = method.function;

    logger.log(
        Level.debug, "$method : $path <<< headers : $headers <<< body : $body");
    Response response = (body == null)
        ? await func.call(url, headers: headers)
        : await func.call(url, headers: headers, body: body);
    logger.log(Level.debug,
        "$method : $method >>> headers : ${response.headers} >>> body : ${response.body}");

    return response;
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
