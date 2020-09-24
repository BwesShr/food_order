import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/models/model.dart';
import 'package:food_order/src/route/generated_route.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/constants.dart';

import '../widget.dart';
import 'amount_widget.dart';
import 'hero_cache_image.dart';

class FoodTile extends StatelessWidget {
  FoodTile({
    Key key,
    @required this.food,
  }) : super(key: key);

  final Food food;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Container(
      width: _appConfig.appWidth(80),
      margin: EdgeInsets.all(
        _appConfig.horizontalPadding(1),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(foodRoute, arguments: new RouteArgument(id: food.id));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: food.media.thumb == null ? '' : food.media.thumb,
                    width: double.infinity,
                    placeholder: (context, url) => ImagePlaceHolder(),
                    errorWidget: (context, url, error) => ImagePlaceHolder(),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(_appConfig.borderRadius()),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(_appConfig.borderRadius()),
                        ),
                      ),
                    ),
                  ),
                  food.rating == null
                      ? Offstage()
                      : Container(
                          width: _appConfig.appWidth(30),
                          height: _appConfig.appHeight(5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: _appConfig.borderRadius(),
                              bottomRight: _appConfig.borderRadius(),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                '${food.rating}',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                        color: Theme.of(context).accentColor),
                              ),
                              Icon(
                                Icons.star,
                                color: Theme.of(context).buttonColor,
                              )
                            ],
                          ),
                        ),
                  Positioned(
                    right: _appConfig.appWidth(6),
                    child: food.discount == 0
                        ? Offstage()
                        : Container(
                            padding:
                                EdgeInsets.all(_appConfig.extraSmallSpace()),
                            decoration: BoxDecoration(
                              color: Theme.of(context).buttonColor,
                            ),
                            child: Text(
                              '${food.discount}%',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    color: AppColors.whiteColor,
                                  ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Text(
              food.name,
              maxLines: 1,
              style: Theme.of(context).textTheme.headline3,
            ),
            AmountWidget(
              food: food,
              textStyle: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }
}
