import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/controller/user_controller.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/validation.dart';
import 'package:food_order/src/widgets/widget.dart';

class MobileScreen extends StatefulWidget {
  MobileScreen({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final UserController controller;

  @override
  _MobileScreenState createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final _mobileController = TextEditingController();
  final _mobileFocus = FocusNode();
  Country _selectedCountry;

  bool _mobileValidated;

  @override
  void initState() {
    super.initState();

    _mobileValidated = false;
    _selectedCountry = CountryPickerUtils.getCountryByPhoneCode('977');

    if (widget.controller.user.phone != null) {
      setState(() {
        _mobileController.text = widget.controller.user.phone;
        _mobileValidated = true;
      });
    }
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
                onTap: openCountryPicker,
                child: Row(
                  children: <Widget>[
                    CountryPickerUtils.getDefaultFlagImage(_selectedCountry),
                    SizedBox(width: 8.0),
                    Text(
                      _selectedCountry.phoneCode,
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
                          _mobileValidated = true;
                        else
                          _mobileValidated = false;
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
                      suffixIcon: _mobileValidated
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
            onPressed: validate,
          ),
          SizedBox(height: _appConfig.hugeSpace()),
        ],
      ),
    );
  }

  /// country select
  void openCountryPicker() => showCupertinoModalPopup<void>(
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

  void validate() {
    final form = widget.controller.loginFormKey.currentState;
    if (form.validate()) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      setState(() => widget.controller.autoValidate = false);
      widget.controller.user.phone = _mobileController.text;
      widget.controller.mobileProcess();
      form.save();
    } else {
      setState(() => widget.controller.autoValidate = true);
    }
  }
}
