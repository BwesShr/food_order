import 'dart:convert';
import 'dart:io';

import 'package:food_order/src/utils/api_config.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:food_order/src/utils/save_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import '../models/model.dart';

ValueNotifier<Setting> appSetting = new ValueNotifier(new Setting());
SaveData _saveData = SaveData();
final _functions = Functions();

Future<Setting> initSettings() async {
  Setting _setting;
  final response = await get(initial_setting_url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  if (response.statusCode == 200) {
    if (json.decode(response.body)['data'] != null) {
      _saveData.saveString(
          _saveData.SETTING, json.encode(json.decode(response.body)['data']));
      _setting = Setting.fromJSON(json.decode(response.body)['data']);
      if (await _saveData.checkValue(_saveData.LANGUAGE_CODE)) {
        _setting.mobileLanguage = new ValueNotifier(
            Locale(await _saveData.getString(_saveData.LANGUAGE_CODE), ''));
      }
      appSetting.value = _setting;
      appSetting.notifyListeners();
    }
  }
  print("initSettings");
  return appSetting.value;
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
