import 'package:flutter/foundation.dart';

class ServerEnv {
  static String get baseUrl => getServerUrl();
  static String developmentBaseUrl = "spotright-dev.nogamsung.com";
  static String productionBaseUrl = "spotright.nogamsung.com";

  static String getServerUrl() {
    if(kDebugMode) {
      return ServerEnv.developmentBaseUrl;
    } else {
      return ServerEnv.productionBaseUrl;
    }
  }
}