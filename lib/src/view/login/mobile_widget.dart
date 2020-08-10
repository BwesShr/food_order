import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/controller/user_controller.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/color_theme.dart';
import 'package:food_order/src/utils/validation.dart';
import 'package:food_order/src/widget/buttons/primary_button.dart';

class MobileWidget extends StatefulWidget {
  MobileWidget({
    Key key,
    @required this.controller,
    @required this.selectedCountry,
    @required this.openCountryPicker,
    @required this.onSubmitClicked,
  }) : super(key: key);

  final UserController controller;
  final Country selectedCountry;
  final VoidCallback openCountryPicker;
  final VoidCallback onSubmitClicked;

  @override
  _MobileWidgetState createState() => _MobileWidgetState();
}

class _MobileWidgetState extends State<MobileWidget> {
  final _mobileController = TextEditingController();
  final _mobileFocus = FocusNode();

  bool _phoneValidated;

  @override
  void initState() {
    super.initState();

    _phoneValidated = false;
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.symmetric(
        horizontal: _appConfig.horizontalSpace(),
      ),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Text(
            LocaleKeys.title_phone.tr(),
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          SizedBox(height: _appConfig.smallSpace()),
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: widget.openCountryPicker,
                child: Row(
                  children: <Widget>[
                    CountryPickerUtils.getDefaultFlagImage(
                        widget.selectedCountry),
                    SizedBox(width: 8.0),
                    Text(
                      widget.selectedCountry.phoneCode,
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Form(
                  key: widget.controller.loginFormKey,
                  child: TextFormField(
                    controller: _mobileController,
                    focusNode: _mobileFocus,
                    keyboardType: TextInputType.phone,
                    validator: phoneValidator,
                    textInputAction: TextInputAction.done,
                    onChanged: (input) {
                      setState(() {
                        if (phoneValidator(input) == null)
                          _phoneValidated = true;
                        else
                          _phoneValidated = false;
                      });
                    },
                    onFieldSubmitted: (value) {
                      _mobileFocus.unfocus();
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      hintText: '9XXXXXXXXX',
                      hintStyle: TextStyle(
                        color: Theme.of(context).focusColor.withOpacity(0.7),
                      ),
                      prefixIcon: Icon(
                        Icons.phone_android,
                        color: Theme.of(context).buttonColor,
                        size: 20.0,
                      ),
                      suffixIcon: _phoneValidated
                          ? Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : Offstage(),
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(),
                      enabledBorder: UnderlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: _appConfig.hugeSpace()),
          PrimaryButton(
            text: LocaleKeys.action_next.tr(),
            onPressed: widget.onSubmitClicked,
          ),
          SizedBox(height: _appConfig.hugeSpace()),
        ],
      ),
    );
  }
}
