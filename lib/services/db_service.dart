\
import 'package:shared_preferences/shared_preferences.dart';

class DbService {
  final SharedPreferences prefs;
  DbService._(this.prefs);

  static Future<DbService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return DbService._(prefs);
  }

  // Simple key-value storage helpers
  Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  String? getString(String key) => prefs.getString(key);

  Future<void> setJson(String key, String json) async {
    await prefs.setString(key, json);
  }

  String? getJson(String key) => prefs.getString(key);
}
