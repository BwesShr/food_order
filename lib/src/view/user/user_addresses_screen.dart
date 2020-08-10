import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/controller/address_controller.dart';
import 'package:food_order/src/model/address.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/widget/address/add_address_button.dart';
import 'package:food_order/src/widget/address/user_address_widget.dart';
import 'package:food_order/src/widget/appbar.dart';
import 'package:food_order/src/widget/progress_dialog.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../route_generator.dart';

class UserAddressesScreen extends StatefulWidget {
  UserAddressesScreen({
    Key key,
    this.isCheckout,
  }) : super(key: key);

  bool isCheckout;

  @override
  _UserAddressesScreenState createState() => _UserAddressesScreenState();
}

class _UserAddressesScreenState extends StateMVC<UserAddressesScreen> {
  AddressController _controller;

  _UserAddressesScreenState() : super(AddressController()) {
    _controller = controller;
  }

  @override
  void initState() {
    _controller.isLoading = true;
    _controller.listenAddresses();

    super.initState();
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
          title: LocaleKeys.title_my_address.tr(),
          onBackPressed: _onBackPressed,
        ),
        body: _controller.isLoading
            ? ProgressDialog()
            : ListView(
                children: <Widget>[
                  AddAddressButton(
                    onAddAddressPressed: () => Navigator.of(context).pushNamed(
                      addAddressRoute,
                      arguments: {arg_address_id: 0},
                    ),
                  ),
                  Divider(),
                  _controller.addresses.length == 0
                      ? Container()
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _controller.addresses.length,
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          itemBuilder: (context, index) {
                            Address address = _controller.addresses[index];
                            return GestureDetector(
                              onTap: () {
                                if (widget.isCheckout)
                                  Navigator.of(context).pop(address);
                              },
                              child: UserAddressWidget(
                                icon: _controller.addressIcon(address),
                                fullName: address.fullName,
                                address: _controller.getLocation(address),
                                onChangeAddressPressed: () =>
                                    _controller.changeAddress(address),
                                isDefault: address.isDefault,
                              ),
                            );
                          },
                        ),
                ],
              ),
      ),
    );
  }
}
