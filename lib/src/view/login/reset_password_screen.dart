import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/controller/user_controller.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/validation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/widget/buttons/primary_button.dart';
import 'package:food_order/src/widget/login/login_text_input.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({
    Key key,
    @required this.controller,
    @required this.onResetPassClicked,
  }) : super(key: key);

  final UserController controller;
  final VoidCallback onResetPassClicked;

  @override
  State<StatefulWidget> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPasswordScreen> {
  final emailController = TextEditingController();
  final emailFocus = FocusNode();

  bool emailValidated = false;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.symmetric(
        horizontal: _appConfig.horizontalPadding(6),
      ),
      child: Form(
        key: widget.controller.loginFormKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            LoginTextInput(
              label: LocaleKeys.hint_email.tr(),
              hint: 'johndoe@email.com',
              validated: emailValidated,
              textController: emailController,
              focusNode: emailFocus,
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
            SizedBox(height: _appConfig.verticalPadding(5)),
            PrimaryButton(
              text: LocaleKeys.action_reset_password.tr(),
              onPressed: widget.onResetPassClicked,
            ),
            SizedBox(height: _appConfig.appHeight(5)),
          ],
        ),
      ),
    );
  }
}
