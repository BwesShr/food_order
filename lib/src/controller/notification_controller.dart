import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../route/generated_route.dart';

class NotificationController extends ControllerMVC {
  final _functions = Functions();

  void userLogin(GlobalKey<ScaffoldState> scaffoldKey) async {
    final message = await Navigator.of(context).pushNamed(loginRoute);
    setState(() {
      _functions.showMessageWithAction(scaffoldKey, context, message);
    });
  }
}
