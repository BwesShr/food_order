import 'package:shared_preferences/shared_preferences.dart';

class SaveData {
  /// save data in shared preference
  String APP_FIRST_RUN = 'app_first_run';
  String APP_THEME = 'app_theme';
  String SETTING = 'setting';
  String LANGUAGE_CODE = 'language';

  /// functions
  SharedPreferences prefs;

  void saveBool(String key, bool message) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, message);
  }

  void saveInt(String key, int message) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, message);
  }

  void saveDouble(String key, double message) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, message);
  }

  void saveString(String key, String message) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, message);
  }

  Future<bool> getBool(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<int> getInt(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<double> getDouble(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  Future<String> getString(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  void removeData(String key) async {
    prefs.remove(key);
  }

  Future<bool> checkValue(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }
}
