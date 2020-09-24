import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_cupertino.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/controller/user_controller.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/view/login/otp_verify_screen.dart';
import 'package:food_order/src/view/login/reset_password_screen.dart';
import 'package:food_order/src/widgets/widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../route/generated_route.dart';
import 'login_user_screen.dart';
import 'mobile_screen.dart';
import 'register_user_screen.dart';
import 'reset_password_screen.dart';

class LoginUserScreen extends StatefulWidget {
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends StateMVC<LoginUserScreen> {
  UserController _controller;

  _LoginUserState() : super(UserController()) {
    _controller = controller;
  }
  @override
  void initState() {
    super.initState();

    if (currentUser.value.apiToken != null) {
      Navigator.of(context).pushReplacementNamed(homeRoute, arguments: 0);
    }
  }

  Future<bool> _onBackPressed() {
    if (_controller.selectedIndex == 0) {
      Navigator.of(context).pop();
    } else if (_controller.selectedIndex == 4) {
      setState(() {
        _controller.selectedIndex = 0;
      });
    } else {
      setState(() {
        _controller.selectedIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: Scaffold(
            key: _controller.scaffoldKey,
            appBar: Appbar(
              title: '',
              onBackPressed: _onBackPressed,
            ),
            body: _controller.isLoading
                ? ProgressDialog()
                : ConnectivityCheck(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: _appConfig.horizontalPadding(6),
                          ),
                          child: Text(
                            _getTitle(),
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        SizedBox(height: _appConfig.appHeight(2)),
                        (_controller.selectedIndex >= 2 &&
                                _controller.selectedIndex < 5)
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: _appConfig.horizontalPadding(6),
                                ),
                                child: Text(
                                  _getSubtitle(),
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              )
                            : SizedBox(),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: _appConfig.verticalSpace(),
                            ),
                            child: _buildGenerateView(),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  _getTitle() {
    switch (_controller.selectedIndex) {
      case 0:
        return LocaleKeys.title_login.tr();

      case 1:
        return LocaleKeys.title_register.tr();

      case 2:
        return LocaleKeys.title_phone.tr();

      case 3:
        return LocaleKeys.title_code_verify.tr();

      case 4:
        return LocaleKeys.title_reset_pass.tr();

      case 5:
        return LocaleKeys.title_reset_pass.tr();

      default:
        return '';
    }
  }

  _getSubtitle() {
    switch (_controller.selectedIndex) {
      case 2:
        return LocaleKeys.subtitle_phone.tr();

      case 3:
        return LocaleKeys.subtitle_code_verify.tr();

      case 4:
        return LocaleKeys.subtitle_reset_pass.tr();

      case 5:
        return '';

      default:
        return '';
    }
  }

  _buildGenerateView() {
    switch (_controller.selectedIndex) {
      case 0:
        return LoginScreen(
          controller: _controller,
          onResetPassClicked: () {
            setState(() {
              _controller.selectedIndex = 4;
            });
          },
          onSignUpClicked: () {
            setState(() {
              _controller.selectedIndex = 1;
            });
          },
        );

      case 1:
        return RegisterScreen(
          controller: _controller,
          onLoginClicked: () {
            setState(() {
              _controller.selectedIndex = 0;
            });
          },
        );

      case 2:
        return MobileScreen(controller: _controller);

      case 3:
        return OtpVerifyScreen(controller: _controller);

      case 4:
        return ResetPasswordScreen(controller: _controller);

      case 5:
        return ConfirmPassword(controller: _controller);
    }
  }
}
