import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/controller/address_controller.dart';
import 'package:food_order/src/models/model.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/widgets/widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../route/generated_route.dart';

class UserAddressesScreen extends StatefulWidget {
  UserAddressesScreen({
    Key key,
  }) : super(key: key);

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
        body: ConnectivityCheck(
          child: _controller.isLoading
              ? ProgressDialog()
              : ListView(
                  children: <Widget>[
                    AddAddressButton(
                      onAddAddressPressed: () =>
                          Navigator.of(context).pushNamed(
                        addAddressRoute,
                        arguments: new RouteArgument(id: 0),
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
      ),
    );
  }
}
