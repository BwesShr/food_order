import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/model.dart';

class UserController extends ControllerMVC {
  User user;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  final _functions = Functions();
  bool hidePassword;
  bool isLoading;
  bool autoValidate;
  int selectedIndex;

  UserController() {
    user = new User.empty();
    loginFormKey = new GlobalKey<FormState>();
    scaffoldKey = new GlobalKey<ScaffoldState>();
    hidePassword = true;
    isLoading = false;
    autoValidate = false;
    selectedIndex = 0;
  }

  runTimer() {
    Timer(Duration(seconds: 20), () {
      setState(() {
        isLoading = false;
      });
      _functions.showMessageWithAction(
          scaffoldKey, context, LocaleKeys.connection_timeout.tr());
    });
  }

  void loginProcess() async {
    setState(() {
      isLoading = true;
    });
    runTimer();
    loginRequest(user).then((value) {
      setState(() {
        isLoading = false;
      });
      if (value['status-code'] == 200) {
        currentUser.value.auth = true;
        String message =
            LocaleKeys.welcome_message.tr() + value['data']['user']['name'];
        Navigator.of(scaffoldKey.currentContext).pop(message);
      } else {
        _functions.showMessageWithAction(
            scaffoldKey, context, value['message']);
      }
    });
  }

  void registerProcess() async {
    setState(() {
      isLoading = true;
    });
    runTimer();
    registerRequest(user).then((value) {
      if (value['status-code'] == 200) {
        setState(() {
          isLoading = false;
          selectedIndex = 2;
        });
        _functions.showMessageWithAction(
            scaffoldKey, context, LocaleKeys.register_message.tr());
      } else if (value['status-code'] == 409) {
        setState(() {
          isLoading = false;
          selectedIndex = 2;
        });
        _functions.showMessageWithAction(
            scaffoldKey, context, LocaleKeys.register_message.tr());
      } else {
        setState(() {
          isLoading = false;
        });
        _functions.showMessageWithAction(
            scaffoldKey, context, value['message']);
      }
    });
  }

  void mobileProcess() {
    setState(() {
      isLoading = true;
    });
    runTimer();
    mobileRequest(user).then((value) {
      if (value['status-code'] == 200) {
        setState(() {
          isLoading = false;
          selectedIndex = 3;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
      _functions.showMessageWithAction(scaffoldKey, context, value['message']);
    });
  }

  void verifyOtpProcess(String code) {
    setState(() {
      isLoading = true;
    });
    runTimer();
    Map<String, dynamic> map = {
      'mobile': user.phone,
      'otp': code,
    };
    verifyOtpRequest(map).then((value) {
      if (value['status-code'] == 200) {
        setState(() {
          isLoading = false;
          selectedIndex = 0;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
      _functions.showMessageWithAction(scaffoldKey, context, value['message']);
    });
  }

  void resetPasswordProcess() {
    setState(() {
      isLoading = true;
    });
    resetPasswordRequest(user).then((value) {
      if (value['status-code'] == 200) {
        setState(() {
          isLoading = false;
          selectedIndex = 5;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
      _functions.showMessageWithAction(scaffoldKey, context, value['message']);
    });
  }

  void confirmPasswordProcess(Map<String, dynamic> map) {
    setState(() {
      isLoading = true;
    });
    confirmPasswordRequest(map).then((value) {
      if (value['status-code'] == 200) {
        setState(() {
          isLoading = false;
          selectedIndex = 0;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
      _functions.showMessageWithAction(scaffoldKey, context, value['message']);
    });
  }
}
