import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/widget/appbar.dart';
import 'package:food_order/src/widget/connectivity_check.dart';

class UserWishListScreen extends StatefulWidget {
  UserWishListScreen({Key key}) : super(key: key);

  @override
  _FavouriteFoodScreenState createState() => _FavouriteFoodScreenState();
}

class _FavouriteFoodScreenState extends State<UserWishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: LocaleKeys.app_name.tr(),
      ),
      body: ConnectivityCheck(child: Container()),
    );
  }
}
