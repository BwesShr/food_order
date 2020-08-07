import 'package:flutter/material.dart';
import 'package:food_order/src/model/walkthrough.dart';
import 'package:food_order/src/utils/app_config.dart' as config;

class WalkthroughEvenItemWidget extends StatelessWidget {
  WalkthroughEvenItemWidget({
    Key key,
    @required this.walkthrough,
  }) : super(key: key);

  final Walkthrough walkthrough;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _appConfig.horizontalSpace(),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                walkthrough.image,
                fit: BoxFit.fitWidth,
              ),
            ),
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
        ],
      ),
    );
  }
}
