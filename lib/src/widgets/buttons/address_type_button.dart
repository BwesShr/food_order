import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/utils/app_config.dart' as config;

class AddressTypeButton extends StatelessWidget {
  AddressTypeButton({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.iconTextColor,
    @required this.buttonColor,
    @required this.onAddressTypePressed,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Color iconTextColor;
  final Color buttonColor;
  final VoidCallback onAddressTypePressed;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    return FlatButton(
      onPressed: onAddressTypePressed,
      color: buttonColor.withOpacity(0.05),
      padding: EdgeInsets.symmetric(
        horizontal: _appConfig.bigSpace(),
        vertical: _appConfig.smallSpace(),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(
          color: buttonColor,
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: buttonColor,
          ),
          SizedBox(width: _appConfig.extraSmallSpace()),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: iconTextColor),
          ),
        ],
      ),
    );
  }
}
