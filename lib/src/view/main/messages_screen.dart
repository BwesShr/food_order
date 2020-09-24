import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/controller/notification_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:food_order/src/widgets/widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({
    Key key,
    this.parentScaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> parentScaffoldKey;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends StateMVC<NotificationScreen> {
  NotificationController _controller;

  _NotificationScreenState() : super(NotificationController()) {
    _controller = controller;
  }
  @override
  Widget build(BuildContext context) {
    return (!currentUser.value.auth)
        ? MessageWidget(
            message: LocaleKeys.subtitle_login_register.tr(),
            buttonText: LocaleKeys.action_login_register.tr(),
            onButtonClicked: () {
              _controller.userLogin(widget.parentScaffoldKey);
            },
          )
        : Container();
  }
}
