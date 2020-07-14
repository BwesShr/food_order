import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
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
      child: RaisedButton(
        onPressed: onPressed,
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Text(
          text,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
