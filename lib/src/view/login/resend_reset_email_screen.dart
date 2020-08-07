import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/controller/user_controller.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/widget/buttons/primary_button.dart';

class ResendResetEmailScreen extends StatefulWidget {
  ResendResetEmailScreen({
    Key key,
    @required this.email,
    @required this.controller,
    @required this.onResendEmailClicked,
  }) : super(key: key);

  String email = '';
  final UserController controller;
  final VoidCallback onResendEmailClicked;

  @override
  State<StatefulWidget> createState() => _ResendResetEmailState();
}

class _ResendResetEmailState extends State<ResendResetEmailScreen> {
  final emailController = TextEditingController();
  final emailFocus = FocusNode();

  bool emailValidated = true;

  @override
  void initState() {
    emailController.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.symmetric(
            horizontal: _appConfig.horizontalPadding(6),
          ),
          child: Form(
            key: widget.controller.loginFormKey,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: _appConfig.appWidth(100.0),
                  height: _appConfig.appHeight(9.0),
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(height: _appConfig.verticalPadding(16)),
              ],
            ),
          ),
        ),
        Container(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(
                horizontal: _appConfig.horizontalPadding(6),
              ),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      right: _appConfig.horizontalPadding(40.0),
                    ),
                    child: Text(
                      LocaleKeys.subtitle_resend_email.tr(),
                      style: Theme.of(context).textTheme.headline1.copyWith(
                            color: Colors.grey,
                            fontSize: 25.0,
                          ),
                    ),
                  ),
                  SizedBox(height: _appConfig.appHeight(15)),
                  PrimaryButton(
                    text: LocaleKeys.action_reset_password.tr(),
                    onPressed: widget.onResendEmailClicked,
                  ),
                  SizedBox(height: _appConfig.appHeight(5)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
