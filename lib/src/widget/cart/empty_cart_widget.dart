import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/controller/cart_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/widget/buttons/primary_button.dart';

class EmptyCartWidget extends StatelessWidget {
  EmptyCartWidget({
    Key key,
    @required this.controller,
    @required this.onCheckPressed,
  }) : super(key: key);

  final CartController controller;
  final VoidCallback onCheckPressed;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Container(
      width: _appConfig.appWidth(100),
      margin: EdgeInsets.symmetric(
        horizontal: _appConfig.horizontalSpace(),
        vertical: _appConfig.verticalSpace(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
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
            text: LocaleKeys.action_check_back.tr(),
            onPressed: onCheckPressed,
          ),
        ],
      ),
    );
  }
}
