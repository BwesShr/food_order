import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_order/src/controller/home_controller.dart';
import 'package:food_order/src/utils/images.dart';
import 'package:food_order/src/widget/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:mvc_pattern/mvc_pattern.dart';

import 'home_trending_food.dart';
import 'home_food_category.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key key,
    this.parentScaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> parentScaffoldKey;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class _HomeScreenState extends StateMVC<HomeScreen> {
  HomeController _controller;
  _HomeScreenState() : super(HomeController()) {
    _controller = controller;
  }

  @override
  void initState() {
    _controller.listenForFoodCategory();
    _controller.listenForTrendingFoods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return RefreshIndicator(
      onRefresh: _controller.refreshHome,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Visibility(
              visible: imageSliders.length > 0 ? true : false,
              child: CarouselSlider(
                options: CarouselOptions(
                  initialPage: 0,
                  autoPlay: true,
                  aspectRatio: 2.2,
                  enlargeCenterPage: true,
                  pauseAutoPlayOnTouch: true,
                  pauseAutoPlayOnManualNavigate: true,
                  autoPlayCurve: Curves.easeInOutCubic,
                  autoPlayInterval: Duration(seconds: 10),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                ),
                items: imageSliders,
              ),
            ),
            SearchBarWidget(),
            HomeFoodCategory(categories: _controller.categories),
            SizedBox(height: 10.0),
            HomeTrendingFood(trendingFoods: _controller.trendingFoods),
          ],
        ),
      ),
    );
  }

  final List<Widget> imageSliders = imgList
      .map(
        (item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: item,
                    width: double.infinity,
                    placeholder: (context, url) =>
                        Image.asset(noProductBackground),
                    errorWidget: (context, url, error) =>
                        Image.asset(noProductBackground),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
      .toList();
}
