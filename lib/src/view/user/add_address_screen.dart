import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/controller/address_controller.dart';
import 'package:food_order/src/model/address.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/constants.dart';
import 'package:food_order/src/utils/validation.dart';
import 'package:food_order/src/widget/appbar.dart';
import 'package:food_order/src/widget/buttons/address_type_button.dart';
import 'package:food_order/src/widget/progress_dialog.dart';
import 'package:food_order/src/widget/text_input_form.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AddAddressScreen extends StatefulWidget {
  AddAddressScreen({
    Key key,
    this.addressId,
  }) : super(key: key);

  int addressId;

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends StateMVC<AddAddressScreen> {
  AddressController _controller;
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _nameFocus = FocusNode();
  final _mobileFocus = FocusNode();
  final _cityFocus = FocusNode();
  final _addressFocus = FocusNode();

  _AddAddressScreenState() : super(AddressController()) {
    _controller = controller;
  }

  @override
  void initState() {
    if (widget.addressId != 0) {
      _controller.isLoading = true;
      _controller.listenAddress(widget.addressId).then((address) {
        setState(() {
          _nameController.text = _controller.address.fullName;
          _mobileController.text = _controller.address.mobile;
          _cityController.text = _controller.address.city;
          _addressController.text = _controller.address.address;
        });
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    _nameController.clear();
    _mobileController.clear();
    _cityController.clear();
    _addressController.clear();
    super.dispose();
  }

  Future<bool> _onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return SafeArea(
      child: Scaffold(
        key: _controller.scaffoldKey,
        appBar: Appbar(
          title: LocaleKeys.title_add_address.tr(),
          onBackPressed: _onBackPressed,
        ),
        body: _controller.isLoading
            ? ProgressDialog()
            : ListView(
                children: <Widget>[
                  Form(
                    key: _controller.formKey,
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: _appConfig.horizontalSpace(),
                      ),
                      children: <Widget>[
                        TextInputForm(
                          label: LocaleKeys.hint_name.tr(),
                          textController: _nameController,
                          focusNode: _nameFocus,
                          nxtFocusNode: _mobileFocus,
                          keyboardType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          validator: textValidator,
                        ),
                        SizedBox(height: _appConfig.smallSpace()),
                        TextInputForm(
                          label: LocaleKeys.hint_phone_number.tr(),
                          textController: _mobileController,
                          focusNode: _mobileFocus,
                          nxtFocusNode: _cityFocus,
                          keyboardType: TextInputType.phone,
                          inputAction: TextInputAction.next,
                          validator: textValidator,
                        ),
                        SizedBox(height: _appConfig.smallSpace()),
                        TextInputForm(
                          label: LocaleKeys.hint_city.tr(),
                          textController: _cityController,
                          focusNode: _cityFocus,
                          nxtFocusNode: _addressFocus,
                          keyboardType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          validator: textValidator,
                        ),
                        SizedBox(height: _appConfig.smallSpace()),
                        TextInputForm(
                          label: LocaleKeys.hint_address.tr(),
                          textController: _addressController,
                          focusNode: _addressFocus,
                          keyboardType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          validator: textValidator,
                        ),
                        SizedBox(height: _appConfig.smallSpace()),
                        Divider(thickness: _appConfig.extraSmallSpace()),
                        SizedBox(height: _appConfig.smallSpace()),
                        Text(
                          LocaleKeys.title_address_type.tr(),
                        ),
                        SizedBox(height: _appConfig.extraSmallSpace()),
                        Row(
                          children: <Widget>[
                            AddressTypeButton(
                              icon: Icons.work,
                              text: LocaleKeys.action_work.tr(),
                              iconTextColor: _controller
                                  .textColor(Constants.addressTypeWork),
                              buttonColor: _controller
                                  .buttonColor(Constants.addressTypeWork),
                              onAddressTypePressed: () =>
                                  _controller.listenAddressTypeClicked(
                                      Constants.addressTypeWork),
                            ),
                            SizedBox(width: _appConfig.smallSpace()),
                            AddressTypeButton(
                              icon: Icons.home,
                              text: LocaleKeys.action_home.tr(),
                              iconTextColor: _controller
                                  .textColor(Constants.addressTypeHome),
                              buttonColor: _controller
                                  .buttonColor(Constants.addressTypeHome),
                              onAddressTypePressed: () =>
                                  _controller.listenAddressTypeClicked(
                                      Constants.addressTypeHome),
                            ),
                          ],
                        ),
                        SizedBox(height: _appConfig.smallSpace()),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                LocaleKeys.make_default_address.tr(),
                              ),
                            ),
                            FlutterSwitch(
                              showOnOff: true,
                              height: _appConfig.appHeight(4),
                              activeColor: Theme.of(context).buttonColor,
                              onToggle: (val) {
                                setState(() {
                                  _controller.address.isDefault = val;
                                });
                              },
                              value: _controller.address.isDefault == null
                                  ? false
                                  : _controller.address.isDefault,
                            ),
                          ],
                        ),
                        SizedBox(height: _appConfig.smallSpace()),
                        Divider(thickness: _appConfig.extraSmallSpace()),
                        SizedBox(height: _appConfig.smallSpace()),
                        InkWell(
                          onTap: _controller.removeAddress,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: _appConfig.verticalSpace()),
                            child: Text(
                              LocaleKeys.action_delete_address.tr(),
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(
                                      color: Theme.of(context).buttonColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
