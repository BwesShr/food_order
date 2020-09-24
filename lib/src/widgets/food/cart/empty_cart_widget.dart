import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/controller/cart_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/widgets/widget.dart';

class EmptyCartWidget extends StatelessWidget {
  EmptyCartWidget({
    Key key,
    @required this.controller,
    @required this.onContinuShoppingPressed,
  }) : super(key: key);

  final CartController controller;
  final VoidCallback onContinuShoppingPressed;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Container(
      width: _appConfig.appWidth(100),
      margin: EdgeInsets.symmetric(
        horizontal: _appConfig.horizontalSpace(),
        vertical: _appConfig.hugeSpace(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(right: _appConfig.appWidth(40)),
            child: Text(
              LocaleKeys.cart_item_empty.tr(),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline1.copyWith(
                    color: Colors.grey,
                    fontSize: 25.0,
                  ),
            ),
          ),
          SizedBox(height: _appConfig.smallSpace()),
          PrimaryButton(
            width: _appConfig.appWidth(50.0),
            text: LocaleKeys.action_continue_Shopping.tr(),
            onPressed: onContinuShoppingPressed,
          ),
        ],
      ),
    );
  }
}
