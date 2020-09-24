import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/utils/save_data.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../route/generated_route.dart';

class SplashScreenController extends ControllerMVC {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  GlobalKey<ScaffoldState> scaffoldKey;
  final _saveData = SaveData();
  bool _firstRun = true;

  SplashScreenController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
  @override
  void initState() {
    getAppFirstRun();

    super.initState();
  }

  Future<void> getAppFirstRun() async {
    _saveData.getBool(_saveData.APP_FIRST_RUN).then((value) {
      if (value == null) value = true;
      _firstRun = value;
    });
  }

  Future<void> changePage() async {
    Timer(Duration(seconds: 5), () {
      if (_firstRun) {
        Navigator.of(context).pushReplacementNamed(walkThroughRoute);
      } else {
        Navigator.of(context).pushReplacementNamed(homeRoute, arguments: 0);
      }
    });
  }
}
