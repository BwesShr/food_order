import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/utils/app_config.dart' as config;

class IconTextButton extends StatelessWidget {
  IconTextButton({
    Key key,
    @required this.width,
    @required this.icon,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  final double width;
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    return Container(
      width: width,
      child: FlatButton(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(
          vertical: _appConfig.verticalSpace(),
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: _appConfig.buttonIconSize(),
              color: Theme.of(context).textTheme.headline3.color,
            ),
            SizedBox(height: _appConfig.extraSmallSpace()),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
