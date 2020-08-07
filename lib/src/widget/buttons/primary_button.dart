import 'package:flutter/material.dart';
import 'package:food_order/src/utils/app_config.dart' as config;

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    Key key,
    @required this.text,
    this.width,
    this.color,
    @required this.onPressed,
  }) : super(key: key);

  final String text;
  final double width;
  Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Container(
      width: width == null ? _appConfig.appWidth(100) : width,
      child: RaisedButton(
        onPressed: onPressed,
        color: color == null ? Theme.of(context).buttonColor : color,
        padding: EdgeInsets.symmetric(vertical: _appConfig.verticalPadding(2)),
        child: Text(
          text,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
