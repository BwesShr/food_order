import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/widgets/widget.dart';

class UserOrderScreen extends StatefulWidget {
  UserOrderScreen({Key key}) : super(key: key);

  @override
  _UserOrderScreenState createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: LocaleKeys.menu_my_orders.tr(),
      ),
      body: ConnectivityCheck(child: Container()),
    );
  }
}
