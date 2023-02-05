import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  void save(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(key, value);
  }

  Future<String> fetch(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key) ?? "";
  }

  Future<void> clear(String key) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(key, "");
  }
}