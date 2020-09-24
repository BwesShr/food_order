import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/controller/payment_controller.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/constants.dart';
import 'package:food_order/src/widgets/widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../route/generated_route.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({Key key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends StateMVC<PaymentScreen> {
  OrderController _controller;

  _PaymentScreenState() : super(OrderController()) {
    _controller = controller;
  }

  @override
  void initState() {
    super.initState();

    _controller.listenForOrder();
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
          title: LocaleKeys.title_payment_method.tr(),
          onBackPressed: _onBackPressed,
        ),
        body: ConnectivityCheck(
          child: _controller.isLoading
              ? ProgressDialog()
              : Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              ListTile(
                                onTap: () => _controller.processPayment(
                                    Constants.paymentCashOnDelivery),
                                leading: Icon(
                                  AppIcons.cash,
                                  color: AppColors.secondaryColor,
                                ),
                                title: Text(
                                  LocaleKeys.action_cash_on_delivery.tr(),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                              Divider(),
                              ListTile(
                                onTap: () => _controller.processPayment(
                                    Constants.paymentCashOnPickup),
                                leading: Icon(
                                  AppIcons.cash,
                                  color: AppColors.secondaryColor,
                                ),
                                title: Text(
                                  LocaleKeys.action_cash_on_pickup.tr(),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _controller.isOrderSuccessFul
                        ? MessageWidget(
                            message: LocaleKeys.order_successful_message.tr(),
                            buttonText: LocaleKeys.action_continue.tr(),
                            onButtonClicked: () =>
                                Navigator.of(context).pushNamedAndRemoveUntil(
                              homeRoute,
                              (Route<dynamic> route) => false,
                              arguments: 0,
                            ),
                          )
                        : Offstage(),
                  ],
                ),
        ),
      ),
    );
  }
}
