import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_order/src/models/model.dart';
import 'package:food_order/src/route/generated_route.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/constants.dart';

class FoodCategoryTile extends StatelessWidget {
  FoodCategoryTile({
    Key key,
    @required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(categoryFoodRoute,
            arguments:
                new RouteArgument(id: category.id, title: category.name));
      },
      child: Container(
        width: _appConfig.appWidth(20),
        margin: EdgeInsets.all(
          _appConfig.horizontalPadding(1),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(
                  _appConfig.horizontalPadding(5),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).buttonColor,
                ),
                child: Center(
                  child: category.image.contains('.svg')
                      ? SvgPicture.network(
                          category.image,
                          color: AppColors.whiteColor,
                          placeholderBuilder: (BuildContext context) =>
                              Image.asset(
                            AppImages.noProductBackground,
                            fit: BoxFit.cover,
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: category.image,
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              Image.asset(AppImages.noProductBackground),
                          errorWidget: (context, url, error) =>
                              Image.asset(AppImages.noProductBackground),
                        ),
                ),
              ),
            ),
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
