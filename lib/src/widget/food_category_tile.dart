import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_order/src/model/category.dart';
import 'package:food_order/src/route_generator.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/color_theme.dart';
import 'package:food_order/src/utils/images.dart';

class FoodCategoryTile extends StatelessWidget {
  Category category;

  FoodCategoryTile({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(categoryFoodRoute, arguments: category);
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              width: _appConfig.appHeight(10),
              height: _appConfig.appHeight(10),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(categoryBackground),
                ),
              ),
              child: Center(
                child: category.image.contains('.svg')
                    ? SvgPicture.network(
                        category.image,
                        width: _appConfig.appHeight(4.5),
                        height: _appConfig.appHeight(4.5),
                        color: whiteColor,
                        placeholderBuilder: (BuildContext context) =>
                            Image.asset(
                          noProductBackground,
                          width: _appConfig.appHeight(4.5),
                          height: _appConfig.appHeight(4.5),
                        ),
                      )
                    : Image.network(
                        category.image,
                        width: _appConfig.appHeight(4.5),
                        height: _appConfig.appHeight(4.5),
                      ),
              ),
            ),
            Text(
              category.name,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
