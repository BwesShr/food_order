import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/model/food.dart';
import 'package:food_order/src/route_generator.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/color_theme.dart';
import 'package:food_order/src/utils/images.dart';

class FoodTile extends StatelessWidget {
  Food food;

  FoodTile({
    Key key,
    @required this.food,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Container(
      width: _appConfig.appWidth(60),
      margin: EdgeInsets.all(_appConfig.horizontalPadding(3)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(foodRoute, arguments: food);
        },
        child: Container(
          padding: EdgeInsets.all(_appConfig.horizontalPadding(3)),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: food.image.thumb,
                  width: double.infinity,
                  placeholder: (context, url) =>
                      Image.asset(noProductBackground),
                  errorWidget: (context, url, error) =>
                      Image.asset(noProductBackground),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                food.name,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: _appConfig.textSize(4),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '',
                      children: <TextSpan>[
                        TextSpan(
                          text: LocaleKeys.currency
                              .tr(namedArgs: {'amount': '${food.price}'}),
                          style: Theme.of(context).textTheme.headline2.copyWith(
                                fontSize: _appConfig.textSize(3.5),
                                decoration: food.discountPrice != 0
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                        ),
                        TextSpan(text: ' '),
                        food.discountPrice != 0
                            ? TextSpan(
                                text: LocaleKeys.currency.tr(namedArgs: {
                                  'amount': '${food.discountPrice}'
                                }),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                      fontSize: _appConfig.textSize(3.5),
                                      color: Theme.of(context).hintColor,
                                    ),
                              )
                            : TextSpan(text: ''),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: Text(
                      LocaleKeys.action_add.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: accentColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
