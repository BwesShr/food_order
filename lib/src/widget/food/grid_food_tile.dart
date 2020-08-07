import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/model/food.dart';
import 'package:food_order/src/route_generator.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/color_theme.dart';
import 'package:food_order/src/widget/image_placeholder.dart';

import 'amount_widget.dart';

class GridFoodTile extends StatelessWidget {
  GridFoodTile({
    Key key,
    @required this.food,
  }) : super(key: key);

  final Food food;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Container(
      margin: EdgeInsets.all(
        _appConfig.horizontalPadding(0.5),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(foodRoute, arguments: {arg_food_id: food.id});
        },
        child: Container(
          padding: EdgeInsets.all(_appConfig.horizontalPadding(0.5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: food.image.thumb,
                      transitionOnUserGestures: true,
                      child: CachedNetworkImage(
                        imageUrl: food.image.thumb,
                        width: double.infinity,
                        height: _appConfig.appWidth(60),
                        placeholder: (context, url) => ImagePlaceHolder(),
                        errorWidget: (context, url, error) =>
                            ImagePlaceHolder(),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(_appConfig.borderRadius()),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    food.rating == null
                        ? Offstage()
                        : Container(
                            width: _appConfig.appWidth(15),
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
                      right: 0.0,
                      child: food.discount == 0
                          ? Offstage()
                          : Container(
                              padding:
                                  EdgeInsets.all(_appConfig.extraSmallSpace()),
                              decoration: BoxDecoration(
                                color: Theme.of(context).buttonColor,
                                borderRadius: BorderRadius.only(
                                  topRight: _appConfig.borderRadius(),
                                ),
                              ),
                              child: Text(
                                '${food.discount}%',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                      color: whiteColor,
                                    ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                food.name,
                maxLines: 2,
                style: Theme.of(context).textTheme.headline3,
              ),
              AmountWidget(
                food: food,
                textStyle: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
