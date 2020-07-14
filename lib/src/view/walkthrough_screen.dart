import 'package:food_order/src/controller/walkthrough_controller.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/images.dart';
import 'package:food_order/src/widget/buttons/primary_button.dart';
import 'package:food_order/src/widget/buttons/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../route_generator.dart';

class WalkthroughScreen extends StatefulWidget {
  WalkthroughScreen({
    Key key,
  }) : super(key: key);

  @override
  _WalkthroughScreenState createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends StateMVC<WalkthroughScreen> {
  WalkthroughController _con;

  _WalkthroughScreenState() : super(WalkthroughController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    return Scaffold(
      body: Container(
        height: _appConfig.appHeight(100),
        child: Column(
          children: [
            Expanded(
              child: Swiper(
                itemCount: _con.pageLength,
                onIndexChanged: (index) {
                  setState(() {
                    _con.updatePageIndex(index);
                  });
                },
                pagination: SwiperPagination(
                  margin: EdgeInsets.only(bottom: _appConfig.appHeight(5)),
                  builder: DotSwiperPaginationBuilder(
                    activeColor: Theme.of(context).hintColor,
                    color: Theme.of(context).hintColor.withOpacity(0.2),
                  ),
                ),
                itemBuilder: (context, index) {
                  return WalkthroughItemWidget(index: index);
                },
              ),
            ),
            PrimaryButton(
              text: 'Next',
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(homeRoute, arguments: 0);
              },
            ),
            Opacity(
              opacity: _con.pageIndex + 1 < _con.pageLength ? 1 : 0,
              child: SecondaryButton(
                text: 'Skip',
                onPressed: () {
                  if (_con.pageIndex + 1 < _con.pageLength) {
                    Navigator.of(context)
                        .pushReplacementNamed(homeRoute, arguments: 0);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WalkthroughItemWidget extends StatelessWidget {
  WalkthroughItemWidget({Key key, @required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    return Stack(
      children: <Widget>[
        Positioned(
          top: 140,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: _appConfig.horizontalPadding(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: _appConfig.appWidth(80),
            height: _appConfig.appHeight(55),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 150),
                Text(
                  'maps_explorer',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.map,
                      color: Theme.of(context).focusColor,
                      size: 28,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'discover__explorer',
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Text(
                  'you_can_discover_restaurants',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
          ),
        ),
        Container(
          height: 220,
          width: _appConfig.appWidth(100),
          margin: EdgeInsets.symmetric(
            horizontal: _appConfig.horizontalPadding(16),
            vertical: _appConfig.verticalPadding(10),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(appIcon),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 50,
                color: Theme.of(context).hintColor.withOpacity(0.2),
              )
            ],
          ),
        ),
      ],
    );
  }
}
