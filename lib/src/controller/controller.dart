import 'package:food_order/src/repository/settings_repo.dart' as settingRepo;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Controller extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  Controller() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  @override
  void initState() {
    settingRepo.initSettings().then((setting) {
      setState(() {
        settingRepo.setting.value = setting;
      });
    });
    // settingRepo.setCurrentLocation().then((locationData) {
    //   setState(() {
    //     settingRepo.locationData = locationData;
    //   });
    // });
//    userRepo.getCurrentUser().then((user) {
//      setState(() {
//        userRepo.currentUser.value = user;
//      });
//    });
  }
}
