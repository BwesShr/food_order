import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/model/address.dart';
import 'package:food_order/src/route_generator.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/model/user.dart';
import 'package:food_order/src/repository/user_repo.dart' as repository;

class UserController extends ControllerMVC {
  User user = new User();
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  bool hidePassword;
  bool resetLiskSend;
  // FirebaseMessaging _firebaseMessaging;

  UserController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    hidePassword = true;
    // _firebaseMessaging = FirebaseMessaging();
    // _firebaseMessaging.getToken().then((String _deviceToken) {
    //   user.deviceToken = _deviceToken;
    // });
  }

  void login() async {
    // TODO: call login api

    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      repository.login(user).then((value) {
        //print(value.apiToken);
        if (value != null && value.apiToken != null) {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(LocaleKeys.welcome_message.tr() + value.name),
          ));
          Navigator.of(scaffoldKey.currentContext)
              .pushReplacementNamed(homeRoute, arguments: {
            arg_current_tab: 0,
          });
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(LocaleKeys.valid_email_password.tr()),
          ));
        }
      });
    }
  }

  void register() async {
    // TODO: call register api

    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      repository.register(user).then((value) {
        if (value != null && value.apiToken != null) {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(LocaleKeys.welcome_message.tr() + value.name),
          ));
          Navigator.of(context).pushReplacementNamed(homeRoute, arguments: {
            arg_current_tab: 0,
          });
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(LocaleKeys.valid_email_password.tr()),
          ));
        }
      });
    }
  }

  void resetPassword() {
    // TODO: call reset password api

// TODO: if successful
    setState(() {
      resetLiskSend = true;
    });
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
            content: Text(LocaleKeys.verify_email_settings),
          ));
        }
      });
    }
  }
}
