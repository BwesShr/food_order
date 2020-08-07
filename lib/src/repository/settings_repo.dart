import 'dart:convert';
import 'dart:io';

import 'package:food_order/src/model/setting.dart';
import 'package:food_order/src/utils/api_config.dart';
import 'package:food_order/src/utils/save_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());
// LocationData locationData;
SaveData _saveData;
SharedPreferences prefs;

Future<Setting> initSettings() async {
  Setting _setting;
  _saveData = SaveData();
  prefs = await SharedPreferences.getInstance();
  final response = await http.get(initial_setting_url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  if (response.statusCode == 200 &&
      response.headers.containsValue('application/json')) {
    if (json.decode(response.body)['data'] != null) {
      await _saveData.saveString(
          _saveData.SETTING, json.encode(json.decode(response.body)['data']));
      _setting = Setting.fromJSON(json.decode(response.body)['data']);
      if (prefs.containsKey(_saveData.LANGUAGE_CODE)) {
        _setting.mobileLanguage =
            new ValueNotifier(Locale(prefs.get(_saveData.LANGUAGE_CODE), ''));
      }
      setting.value = _setting;
      setting.notifyListeners();
    }
  }
  print("initSettings");
  return setting.value;
}

// Future<LocationData> setCurrentLocation() async {
//   var location = new Location();
//   location.requestService().then((value) async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       locationData = await location.getLocation();
//       await prefs.setDouble('currentLat', locationData.latitude);
//       await prefs.setDouble('currentLon', locationData.longitude);
//     } on PlatformException catch (e) {
//       if (e.code == 'PERMISSION_DENIED') {
//         print('Permission denied');
//       }
//     }
//   });
//   return locationData;
// }

// Future<LocationData> getCurrentLocation() async {
//   print("getCurrentLocation");
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey('currentLat') && prefs.containsKey('currentLon')) {
//     locationData = LocationData.fromMap({"latitude": prefs.getDouble('currentLat'), "longitude": prefs.getDouble('currentLon')});
//   } else {
//     setCurrentLocation().then((value) {
//       if (prefs.containsKey('currentLat') && prefs.containsKey('currentLon')) {
//         locationData = LocationData.fromMap({"latitude": prefs.getDouble('currentLat'), "longitude": prefs.getDouble('currentLon')});
//       }
//     });
//   }
//   return locationData;
// }

void setBrightness(Brightness brightness) async {
  brightness == Brightness.dark
      ? _saveData.saveBool(_saveData.APP_THEME, true)
      : _saveData.saveBool(_saveData.APP_THEME, false);
}

Future<bool> getAppTheme() async {
  bool appTheme = false;
  await _saveData.getBool(_saveData.APP_THEME).then((value) {
    if (value == null) value = false;
    appTheme = value;
  });
  return appTheme;
}

Future<void> setDefaultLanguage(String language) async {
  if (language != null) {
    _saveData.saveString(_saveData.LANGUAGE_CODE, language);
  }
}

Future<String> getDefaultLanguage() async {
  String defaultLanguage;
  await _saveData.getString(_saveData.LANGUAGE_CODE).then((value) {
    if (value == null) value = '';
    defaultLanguage = value;
  });

  return defaultLanguage;
}
