import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/models/model.dart';
import 'package:food_order/src/utils/app_config.dart' as config;

class WalkthroughOddItemWidget extends StatelessWidget {
  WalkthroughOddItemWidget({
    Key key,
    @required this.walkthrough,
  }) : super(key: key);

  final Walkthrough walkthrough;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        SizedBox(
          height: _appConfig.verticalSpace(),
        ),
        Text(
          walkthrough.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline2,
        ),
        Text(
          walkthrough.subtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Image.asset(
              walkthrough.image,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ],
    );
  }
}
