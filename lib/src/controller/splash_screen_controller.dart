import 'dart:async';

import 'package:food_order/src/repository/settings_repo.dart';
import 'package:food_order/src/utils/save_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../route_generator.dart';

class SplashScreenController extends ControllerMVC {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  GlobalKey<ScaffoldState> scaffoldKey;
  final _saveData = SaveData();
  bool _firstRun = true;

  SplashScreenController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // Should define these variable before the app loaded
    // progress.value = {"Setting": 0};
  }
  @override
  void initState() {
    getAppFirstRun();
    // settingRepo.setting.addListener(() {
    //   if (settingRepo.setting.value.appName != null &&
    //       settingRepo.setting.value.mainColor != null) {
    //     progress.value["Setting"] = 100;
    //     progress.notifyListeners();
    //   }
    // });

//    currentUser.addListener(() {
//      if (currentUser.value.auth != null) {
//        progress.value["User"] = 50;
//        progress.notifyListeners();
//      }
//    });
    // Timer(Duration(seconds: 20), () {
    //   scaffoldKey?.currentState?.showSnackBar(SnackBar(
    //     content: Text('verify_your_internet_connection'),
    //   ));
    // });

    super.initState();
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }
    print('splash screen myBackgroundMessageHandler');
  }

  Future<void> changePage() async {
    Timer(Duration(seconds: 5), () {
      if (_firstRun) {
        Navigator.of(context).pushReplacementNamed(walkThroughRoute);
      } else {
        Navigator.of(context)
            .pushReplacementNamed(homeRoute, arguments: {arg_current_tab: 0});
      }
    });
  }

  Future<void> getAppFirstRun() async {
    _saveData.getBool(_saveData.APP_FIRST_RUN).then((value) {
      if (value == null) value = true;
      _firstRun = value;
    });
  }
}
