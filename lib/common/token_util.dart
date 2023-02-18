import 'package:jwt_decode/jwt_decode.dart';

class TokenUtil {
  bool isValidToken({String? token, int afterMinutes = 0}) {
    if(token == null) return false;

    // Bearer 제거
    DateTime? expiryDate = Jwt.getExpiryDate(token.split(" ")[1]);
    DateTime now = DateTime.now();
    DateTime targetTime = now.add(Duration(minutes: afterMinutes));

    if(expiryDate == null) return false;

    return targetTime.isBefore(expiryDate);
  }

  List<String> getTokens(String authorization) {

    List<String> splitTokens = authorization.substring(1, authorization.length - 1).split(",");
    String newAccessToken = splitTokens[0].split(":")[1].replaceAll(" ", "");
    String newRefreshToken = splitTokens[1].split(":")[1].replaceAll(" ", "");

    return [
      "Bearer $newAccessToken",
      "Bearer $newRefreshToken",
    ];
  }
}