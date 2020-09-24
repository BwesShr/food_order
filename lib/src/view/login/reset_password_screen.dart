import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/controller/user_controller.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/validation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/widgets/widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final UserController controller;

  @override
  State<StatefulWidget> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();
  final _emailFocus = FocusNode();

  bool _emailValidated;

  @override
  void initState() {
    super.initState();
    _emailValidated = false;

    if (widget.controller.user.email != null) {
      setState(() {
        _emailController.text = widget.controller.user.email;
        _emailValidated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Container(
      alignment: Alignment.bottomCenter,
      child: Form(
        key: widget.controller.loginFormKey,
        autovalidate: widget.controller.autoValidate,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            LoginTextInput(
              label: LocaleKeys.hint_email.tr(),
              hint: 'johndoe@email.com',
              validated: _emailValidated,
              textController: _emailController,
              focusNode: _emailFocus,
              prefixIcon: AppIcons.mail,
              keyboardType: TextInputType.emailAddress,
              inputAction: TextInputAction.next,
              validator: emailValidator,
              onChanged: (input) {
                setState(() {
                  if (emailValidator(input) == null)
                    _emailValidated = true;
                  else
                    _emailValidated = false;
                });
              },
            ),
            SizedBox(height: _appConfig.hugeSpace()),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: _appConfig.horizontalPadding(6),
              ),
              child: PrimaryButton(
                text: LocaleKeys.action_reset_password.tr(),
                onPressed: validate,
              ),
            ),
            SizedBox(height: _appConfig.hugeSpace()),
          ],
        ),
      ),
    );
  }

  void validate() {
    final form = widget.controller.loginFormKey.currentState;
    if (form.validate()) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      setState(() => widget.controller.autoValidate = false);
      widget.controller.user.email = _emailController.text;
      widget.controller.resetPasswordProcess();
      form.save();
    } else {
      setState(() => widget.controller.autoValidate = true);
    }
  }
}

class ConfirmPassword extends StatefulWidget {
  ConfirmPassword({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final UserController controller;

  @override
  _ConfirmPasswordState createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _passwordFocus = FocusNode();
  final _passwordConfirmFocus = FocusNode();

  bool _passwordValidated;
  bool _passwordConfirmValidated;

  @override
  void initState() {
    super.initState();

    _passwordValidated = false;
    _passwordConfirmValidated = false;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              LoginTextInput(
                enable: false,
                label: LocaleKeys.hint_email.tr(),
                hint: 'johndoe@email.com',
                validated: true,
                textController:
                    TextEditingController(text: widget.controller.user.email),
                focusNode: FocusNode(),
                prefixIcon: AppIcons.mail,
                keyboardType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                validator: emailValidator,
              ),
              SizedBox(height: _appConfig.hugeSpace()),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: _appConfig.horizontalPadding(6),
                ),
                child: PrimaryButton(
                  color: Theme.of(context).primaryColor,
                  text: LocaleKeys.action_reset_password.tr(),
                  onPressed: validate,
                ),
              ),
              SizedBox(height: _appConfig.hugeSpace()),
            ],
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
                horizontal: _appConfig.horizontalSpace(),
              ),
              child: Form(
                key: widget.controller.loginFormKey,
                autovalidate: widget.controller.autoValidate,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    LoginTextInput(
                      label: LocaleKeys.hint_password.tr(),
                      hint: '••••••••••',
                      validated: _passwordValidated,
                      textController: _passwordController,
                      focusNode: _passwordFocus,
                      nxtFocusNode: _passwordConfirmFocus,
                      prefixIcon: AppIcons.key,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: passwordValidator,
                      onChanged: (input) {
                        setState(() {
                          if (passwordValidator(input) == null)
                            _passwordValidated = true;
                          else
                            _passwordValidated = false;
                        });
                      },
                    ),
                    SizedBox(height: _appConfig.smallSpace()),
                    LoginTextInput(
                      label: LocaleKeys.hint_password_confirm.tr(),
                      hint: '••••••••••',
                      validated: _passwordConfirmValidated,
                      textController: _passwordConfirmController,
                      focusNode: _passwordConfirmFocus,
                      prefixIcon: AppIcons.key,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.done,
                      validator: (input) => passwordConfirmValidator(
                          input, _passwordController.text),
                      onChanged: (input) {
                        setState(() {
                          if (passwordConfirmValidator(
                                  input, _passwordController.text) ==
                              null)
                            _passwordConfirmValidated = true;
                          else
                            _passwordConfirmValidated = false;
                        });
                      },
                    ),
                    SizedBox(height: _appConfig.hugeSpace()),
                    PrimaryButton(
                      text: LocaleKeys.action_reset_password.tr(),
                      onPressed: validate,
                    ),
                    SizedBox(height: _appConfig.hugeSpace()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void validate() {
    final form = widget.controller.loginFormKey.currentState;
    if (form.validate()) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      setState(() => widget.controller.autoValidate = false);
      Map<String, dynamic> body = {
        'password': _passwordController.text,
        'confirm_password': _passwordConfirmController.text,
      };
      widget.controller.confirmPasswordProcess(body);
      form.save();
    } else {
      setState(() => widget.controller.autoValidate = true);
    }
  }
}
