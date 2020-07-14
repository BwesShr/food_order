import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/color_theme.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  SecondaryButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Container(
      width: _appConfig.appWidth(100),
      margin: EdgeInsets.symmetric(
        horizontal: _appConfig.horizontalPadding(10),
      ),
      child: FlatButton(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(
          vertical: _appConfig.horizontalPadding(5),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(color: btnPrimaryColor),
        ),
      ),
    );
  }
}
