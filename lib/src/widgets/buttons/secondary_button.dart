import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  SecondaryButton({
    Key key,
    @required this.text,
    this.width,
    @required this.onPressed,
  }) : super(key: key);

  final String text;
  final double width;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Container(
      width: width == null ? _appConfig.appWidth(100) : width,
      child: FlatButton(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(
          vertical: _appConfig.verticalSpace(),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(color: Theme.of(context).buttonColor),
        ),
      ),
    );
  }
}
