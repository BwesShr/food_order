import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/controller/user_controller.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/utils/validation.dart';
import 'package:food_order/src/widgets/widget.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({
    Key key,
    @required this.controller,
    @required this.onLoginClicked,
  }) : super(key: key);

  final UserController controller;
  final VoidCallback onLoginClicked;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _passwordConfirmFocus = FocusNode();
  bool _nameValidated;
  bool _emailValidated;
  bool _passwordValidated;
  bool _passwordConfirmValidated;

  @override
  void initState() {
    super.initState();

    _nameValidated = false;
    _emailValidated = false;
    _passwordValidated = false;
    _passwordConfirmValidated = false;

    if (widget.controller.user.name != null) {
      setState(() {
        _nameController.text = widget.controller.user.name;
        _nameValidated = true;
      });
    }
    if (widget.controller.user.email != null) {
      setState(() {
        _emailController.text = widget.controller.user.email;
        _emailValidated = true;
      });
    }
    if (widget.controller.user.password != null) {
      setState(() {
        _passwordController.text = widget.controller.user.password;
        _passwordConfirmController.text = widget.controller.user.password;
        _passwordValidated = true;
        _passwordConfirmValidated = true;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
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
              label: LocaleKeys.hint_name.tr(),
              hint: 'John Doe',
              validated: _nameValidated,
              textController: _nameController,
              focusNode: _nameFocus,
              nxtFocusNode: _emailFocus,
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              validator: textValidator,
              onChanged: (input) {
                setState(() {
                  if (textValidator(input) == null)
                    _nameValidated = true;
                  else
                    _nameValidated = false;
                });
              },
            ),
            SizedBox(height: _appConfig.smallSpace()),
            LoginTextInput(
              label: LocaleKeys.hint_email.tr(),
              hint: 'johndoe@email.com',
              validated: _emailValidated,
              textController: _emailController,
              focusNode: _emailFocus,
              nxtFocusNode: _passwordFocus,
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
            SizedBox(height: _appConfig.smallSpace()),
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
              validator: (input) =>
                  passwordConfirmValidator(input, _passwordController.text),
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
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: _appConfig.horizontalPadding(6),
              ),
              child: PrimaryButton(
                text: LocaleKeys.action_next.tr(),
                onPressed: validate,
              ),
            ),
            SizedBox(height: _appConfig.smallSpace()),
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
      widget.controller.user.name = _nameController.text;
      widget.controller.user.email = _emailController.text;
      widget.controller.user.password = _passwordController.text;
      widget.controller.registerProcess();
      form.save();
    } else {
      setState(() => widget.controller.autoValidate = true);
    }
  }
}
