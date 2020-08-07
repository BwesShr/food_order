import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/route_generator.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/model/user.dart';
import 'package:food_order/src/repository/user_repo.dart' as repository;

class UserController extends ControllerMVC {
  User user = new User();
  bool hidePassword = true;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  // FirebaseMessaging _firebaseMessaging;

  UserController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // _firebaseMessaging = FirebaseMessaging();
    // _firebaseMessaging.getToken().then((String _deviceToken) {
    //   user.deviceToken = _deviceToken;
    // });
  }

  void login() async {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      repository.login(user).then((value) {
        //print(value.apiToken);
        if (value != null && value.apiToken != null) {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(LocaleKeys.welcome_message.tr() +
                value.fname +
                ' ' +
                value.lname),
          ));
          Navigator.of(scaffoldKey.currentContext)
              .pushReplacementNamed(homeRoute, arguments: {arg_current_tab: 0});
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(LocaleKeys.valid_email_password.tr()),
          ));
        }
      });
    }
  }

  void register() async {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      repository.register(user).then((value) {
        if (value != null && value.apiToken != null) {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(LocaleKeys.welcome_message.tr() +
                value.fname +
                ' ' +
                value.lname),
          ));
          Navigator.of(context)
              .pushReplacementNamed(homeRoute, arguments: {arg_current_tab: 0});
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(LocaleKeys.valid_email_password.tr()),
          ));
        }
      });
    }
  }

  void resetPassword() {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      repository.resetPassword(user).then((value) {
        if (value != null && value == true) {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(LocaleKeys.reset_link_sent_to_email),
            action: SnackBarAction(
              label: LocaleKeys.action_login,
              onPressed: () {
                Navigator.of(scaffoldKey.currentContext)
                    .pushReplacementNamed('/Login');
              },
            ),
            duration: Duration(seconds: 10),
          ));
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(LocaleKeys.error_verify_email_settings),
          ));
        }
      });
    }
  }
}
