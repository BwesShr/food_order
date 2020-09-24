import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Controller extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  Controller() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  @override
  void initState() {
    initSettings().then((_setting) {
      setState(() {
        appSetting.value = _setting;
      });
    });
    // settingRepo.setCurrentLocation().then((locationData) {
    //   setState(() {
    //     settingRepo.locationData = locationData;
    //   });
    // });
    getCurrentUser().then((_user) {
      setState(() {
        currentUser.value = _user;
      });
    });
  }
}
