import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/utils/app_config.dart' as config;

class AddAddressButton extends StatelessWidget {
  const AddAddressButton({
    Key key,
    @required this.onAddAddressPressed,
  }) : super(key: key);

  final VoidCallback onAddAddressPressed;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return GestureDetector(
      onTap: onAddAddressPressed,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: _appConfig.horizontalSpace(),
        ),
        child: DottedBorder(
          color: Theme.of(context).accentColor,
          strokeWidth: 1,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: _appConfig.horizontalSpace(),
              vertical: _appConfig.bigSpace(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(AppIcons.add),
                Text(
                  LocaleKeys.action_add_address.tr(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
