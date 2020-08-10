import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/model/address.dart';
import 'package:food_order/src/repository/address_repo.dart';
import 'package:food_order/src/utils/color_theme.dart';
import 'package:food_order/src/utils/constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../route_generator.dart';

class AddressController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;
  List<Address> addresses = new List();
  Address address = new Address.empty();
  bool isLoading;

  AddressController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    formKey = new GlobalKey<FormState>();
    isLoading = false;
  }

  Future<Address> listenAddress(int addressId) async {
    // TODO: call user's address by id api

    await Future.delayed(Duration(seconds: 4));
    List<Address> _addresses = getAddresses();
    _addresses.forEach((item) {
      setState(() {
        isLoading = false;
        address = _addresses.firstWhere((data) => data.id == addressId);
      });
    });
    return address;
  }

  Future<void> listenAddresses({String message}) async {
    // TODO: call user's all address api

    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isLoading = false;
      addresses = getAddresses();
    });
  }

  void listenAddressTypeClicked(String type) {
    setState(() {
      address.type = type;
    });
  }

  IconData addressIcon(Address _address) {
    switch (_address.type) {
      case Constants.addressTypeHome:
        return Icons.home;
      case Constants.addressTypeWork:
        return Icons.work;
      default:
        return null;
    }
  }

  String getLocation(Address _address) {
    return _address.address + ', ' + _address.city;
  }

  Color buttonColor(String addressType) {
    if (address.type == addressType)
      return Theme.of(context).buttonColor;
    else
      return blackColor.withOpacity(0.5);
  }

  Color textColor(String addressType) {
    if (address.type == addressType)
      return Theme.of(context).buttonColor;
    else
      return blackColor;
  }

  void removeAddress() {
    if (!address.isDefault) {
      // TODO: call remove address api
    } else {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(LocaleKeys.default_address_delete).tr(),
      ));
    }
  }

  void changeAddress(Address _address) {
    Navigator.of(context)
        .pushNamed(addAddressRoute, arguments: {arg_address_id: _address.id});
  }
}
