import 'package:flutter/material.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/controller/food_controller.dart';
import 'package:food_order/src/model/extra.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/color_theme.dart';

class ExtraListWidget extends StatelessWidget {
  ExtraListWidget({
    Key key,
    @required this.controller,
    @required this.extras,
  }) : super(key: key);

  final FoodController controller;
  final List<Extra> extras;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return ListView.separated(
      shrinkWrap: true,
      itemCount: extras.length,
      physics: ClampingScrollPhysics(),
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemBuilder: (context, index) {
        Extra extra = extras[index];
        return InkWell(
          onTap: () => controller.listenFoodExtraClicked(extra),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: _appConfig.extraSmallSpace(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  extra.name,
                  style: Theme.of(context).textTheme.caption,
                ),
                controller.checkExtra(extra)
                    ? Icon(
                        AppIcons.check,
                        color: secondaryColor,
                      )
                    : Icon(AppIcons.circle),
              ],
            ),
          ),
        );
      },
    );
  }
}
