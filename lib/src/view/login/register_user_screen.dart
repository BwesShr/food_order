import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/controller/user_controller.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/utils/validation.dart';
import 'package:food_order/src/widget/buttons/primary_button.dart';
import 'package:food_order/src/widget/login/login_text_input.dart';

class RegisterUserScreen extends StatefulWidget {
  RegisterUserScreen({
    Key key,
    @required this.controller,
    @required this.onNextClicked,
    @required this.onLoginClicked,
  }) : super(key: key);

  final UserController controller;
  final VoidCallback onNextClicked;
  final VoidCallback onLoginClicked;

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUserScreen> {
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final fNameFocus = FocusNode();
  final lNameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final passwordConfirmFocus = FocusNode();

  bool fNameValidated = false;
  bool lNameValidated = false;
  bool emailValidated = false;
  bool passwordValidated = false;
  bool passwordConfirmValidated = false;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Container(
      alignment: Alignment.bottomCenter,
      child: Form(
        key: widget.controller.loginFormKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: LoginTextInput(
                    label: LocaleKeys.hint_fname.tr(),
                    hint: 'John',
                    validated: fNameValidated,
                    textController: fNameController,
                    focusNode: fNameFocus,
                    nxtFocusNode: lNameFocus,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: textValidator,
                    onChanged: (input) {
                      setState(() {
                        if (textValidator(input) == null)
                          fNameValidated = true;
                        else
                          fNameValidated = false;
                      });
                    },
                  ),
                ),
                SizedBox(width: _appConfig.appHeight(2)),
                Expanded(
                  child: LoginTextInput(
                    label: LocaleKeys.hint_lname.tr(),
                    hint: 'Doe',
                    validated: lNameValidated,
                    textController: lNameController,
                    focusNode: lNameFocus,
                    nxtFocusNode: emailFocus,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: textValidator,
                    onChanged: (input) {
                      setState(() {
                        if (textValidator(input) == null)
                          lNameValidated = true;
                        else
                          lNameValidated = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: _appConfig.appHeight(2)),
            LoginTextInput(
              label: LocaleKeys.hint_email.tr(),
              hint: 'johndoe@email.com',
              validated: emailValidated,
              textController: emailController,
              focusNode: emailFocus,
              nxtFocusNode: passwordFocus,
              prefixIcon: AppIcons.mail,
              keyboardType: TextInputType.emailAddress,
              inputAction: TextInputAction.next,
              validator: emailValidator,
              onChanged: (input) {
                setState(() {
                  if (emailValidator(input) == null)
                    emailValidated = true;
                  else
                    emailValidated = false;
                });
              },
            ),
            SizedBox(height: _appConfig.appHeight(2)),
            LoginTextInput(
              label: LocaleKeys.hint_password.tr(),
              hint: '••••••••••',
              validated: passwordValidated,
              textController: passwordController,
              focusNode: passwordFocus,
              nxtFocusNode: passwordConfirmFocus,
              prefixIcon: AppIcons.key,
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              validator: passwordValidator,
              onChanged: (input) {
                setState(() {
                  if (passwordValidator(input) == null)
                    passwordValidated = true;
                  else
                    passwordValidated = false;
                });
              },
            ),
            SizedBox(height: _appConfig.appHeight(2)),
            LoginTextInput(
              label: LocaleKeys.hint_password_confirm.tr(),
              hint: '••••••••••',
              validated: passwordConfirmValidated,
              textController: passwordConfirmController,
              focusNode: passwordConfirmFocus,
              prefixIcon: AppIcons.key,
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.done,
              validator: (input) {
                passwordConfirmValidator(input, passwordController.text);
              },
              onChanged: (input) {
                String validate =
                    passwordConfirmValidator(input, passwordController.text);
                setState(() {
                  if (validate == null)
                    passwordConfirmValidated = true;
                  else
                    passwordConfirmValidated = false;
                });
              },
            ),
            SizedBox(height: _appConfig.verticalPadding(8)),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: _appConfig.horizontalPadding(6),
              ),
              child: PrimaryButton(
                text: LocaleKeys.action_next.tr(),
                onPressed: () {
                  // if (widget.controller.loginFormKey.currentState
                  //     .validate()) {
                  //   widget.controller.loginFormKey.currentState.save();
                  widget.onNextClicked();
                  // }
                },
              ),
            ),
            SizedBox(height: _appConfig.appHeight(2)),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: LocaleKeys.already_registered_message.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 16.0),
                  ),
                  TextSpan(text: ' '),
                  TextSpan(
                    text: LocaleKeys.action_login.tr(),
                    style: Theme.of(context).textTheme.button.copyWith(
                          fontSize: 16.0,
                          color: Theme.of(context).buttonColor,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onLoginClicked,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: _appConfig.appHeight(5)),
          ],
        ),
      ),
    );
  }
}
