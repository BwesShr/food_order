import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_cupertino.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/controller/user_controller.dart';
import 'package:food_order/src/repository/user_repo.dart' as userRepo;
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/view/login/otp_verify_screen.dart';
import 'package:food_order/src/view/login/reset_password_screen.dart';
import 'package:food_order/src/widget/appbar.dart';
import 'package:food_order/src/widget/connectivity_check.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../route_generator.dart';
import 'login_user_screen.dart';
import 'mobile_widget.dart';
import 'register_user_screen.dart';
import 'reset_password_screen.dart';

class LoginUserScreen extends StatefulWidget {
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends StateMVC<LoginUserScreen> {
  UserController _controller;
  Country _selectedCountry;
  int _selectedIndex;

  _LoginUserState() : super(UserController()) {
    _controller = controller;
  }
  @override
  void initState() {
    super.initState();

    _selectedIndex = 0;
    _selectedCountry = CountryPickerUtils.getCountryByPhoneCode('977');

    if (userRepo.currentUser.value.apiToken != null) {
      Navigator.of(context).pushReplacementNamed(homeRoute, arguments: {
        arg_current_tab: 0,
      });
    }
  }

  Future<bool> _onBackPressed() {
    if (_selectedIndex == 0) {
      Navigator.of(context).pop();
    } else if (_selectedIndex == 4) {
      setState(() {
        _selectedIndex = 0;
      });
    } else {
      setState(() {
        _selectedIndex--;
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
            body: ConnectivityCheck(
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
                  (_selectedIndex >= 2 && _selectedIndex < 5)
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
                        vertical: _appConfig.verticalPadding(3),
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
    switch (_selectedIndex) {
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

      default:
        return '';
    }
  }

  _getSubtitle() {
    switch (_selectedIndex) {
      case 2:
        return LocaleKeys.subtitle_phone.tr();

      case 3:
        return LocaleKeys.subtitle_code_verify.tr();

      case 4:
        return LocaleKeys.subtitle_reset_pass.tr();

      default:
        return '';
    }
  }

  _buildGenerateView() {
    switch (_selectedIndex) {
      case 0:
        return LoginWidget(
          controller: _controller,
          onLoginClicked: _controller.login,
          onSignUpClicked: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
          onResetPassClicked: () {
            setState(() {
              _selectedIndex = 4;
            });
          },
        );

      case 1:
        return RegisterScreen(
          controller: _controller,
          onNextClicked: () {
            setState(() {
              _selectedIndex = 2;
            });
          },
          onLoginClicked: () {
            if (_controller.loginFormKey.currentState.validate()) {
              _controller.loginFormKey.currentState.save();
              setState(() {
                _selectedIndex = 1;
              });
            }
          },
        );

      case 2:
        return MobileWidget(
          controller: _controller,
          selectedCountry: _selectedCountry,
          openCountryPicker: _openCountryPicker,
          onSubmitClicked: () {
            // _con.register();
            setState(() {
              _selectedIndex = 3;
            });
          },
        );

      case 3:
        return OtpVerifyScreen(
          mobileNumber: null,
          onReSendCodePressed: () {},
          onCodeVerifyPressed: (code) {},
        );

      case 4:
        return ResetPasswordScreen(
          controller: _controller,
          onResetPassClicked: () {
            setState(() {
              _controller.resetLiskSend = true;
            });
          },
        );
    }
  }

  /// country select
  void _openCountryPicker() => showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return CountryPickerCupertino(
            backgroundColor: Colors.white,
            pickerSheetHeight: 200.0,
            initialCountry: _selectedCountry,
            onValuePicked: (Country country) =>
                setState(() => _selectedCountry = country),
            itemFilter: (phone) => ['977'].contains(phone.phoneCode),
          );
        },
      );
}
