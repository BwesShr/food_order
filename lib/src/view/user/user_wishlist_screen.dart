import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/widgets/widget.dart';

class UserWishListScreen extends StatefulWidget {
  UserWishListScreen({Key key}) : super(key: key);

  @override
  _FavouriteFoodScreenState createState() => _FavouriteFoodScreenState();
}

class _FavouriteFoodScreenState extends State<UserWishListScreen> {
  void _onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: LocaleKeys.title_wishlist.tr(),
        onBackPressed: _onBackPressed,
      ),
      body: ConnectivityCheck(child: Container()),
    );
  }
}
