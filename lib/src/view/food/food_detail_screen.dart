import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tab_bar_no_ripple/flutter_tab_bar_no_ripple.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/controller/food_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/color_theme.dart';
import 'package:food_order/src/widget/appbar.dart';
import 'package:food_order/src/widget/buttons/primary_button.dart';
import 'package:food_order/src/widget/connectivity_check.dart';
import 'package:food_order/src/widget/food/amount_widget.dart';
import 'package:food_order/src/widget/food/extra_list_widget.dart';
import 'package:food_order/src/widget/food/food_description.dart';
import 'package:food_order/src/widget/food/food_review_widget.dart';
import 'package:food_order/src/widget/food/ingrident_grid_widget.dart';
import 'package:food_order/src/widget/image_placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:parallax_image/parallax_image.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FoodDetailScreen extends StatefulWidget {
  FoodDetailScreen({
    Key key,
    @required this.foodId,
    bool isCartItem,
  })  : _isCartItem = isCartItem != null ? isCartItem : false,
        super(key: key);

  final int foodId;
  bool _isCartItem = false;

  @override
  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends StateMVC<FoodDetailScreen>
    with SingleTickerProviderStateMixin {
  FoodController _controller;
  ScrollController _scrollController;
  bool lastStatus = true;
  String _title;
  double _imageHeight;
  TabController _tabController;

  _FoodDetailScreenState() : super(FoodController()) {
    _controller = controller;
  }

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    _tabController.index = 0;
    _title = LocaleKeys.title_product_detail.tr();
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    super.initState();
    _controller.listenForCartCount();
    if (widget._isCartItem) {
      _controller.listenForCartById(foodId: widget.foodId);
    } else {
      _controller.listenForFoodById(foodId: widget.foodId);
    }
  }

  @override
  void dispose() {
    // SystemChrome.setEnabledSystemUIOverlays(
    //     [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    // _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  _scrollListener() {
    if (isShrink) {
      SystemChrome.setEnabledSystemUIOverlays(
          [SystemUiOverlay.top, SystemUiOverlay.bottom]);
      setState(() {
        _title = _controller.food.name;
      });
    } else {
      setState(() {
        _title = LocaleKeys.title_product_detail.tr();
      });
    }
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (_imageHeight - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    _imageHeight = _appConfig.sliverImageHeight();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ConnectivityCheck(
            child: _controller.food == null
                ? Center(child: CircularProgressIndicator())
                : Container(
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView(
                            controller: _scrollController,
                            padding: EdgeInsets.all(0.0),
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    child: Hero(
                                      tag: _controller.food.image.thumb,
                                      child: CachedNetworkImage(
                                        imageUrl: _controller.food.image.thumb,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            ImagePlaceHolder(),
                                        errorWidget: (context, url, error) =>
                                            ImagePlaceHolder(),
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                ParallaxImage(
                                          controller: _scrollController,
                                          extent: _imageHeight,
                                          image: imageProvider,
                                          child: Container(
                                            color: blackTransparentColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: _appConfig.appHeight(40)),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: _appConfig.horizontalSpace(),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: _appConfig.borderRadius(),
                                        topRight: _appConfig.borderRadius(),
                                      ),
                                    ),
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: <Widget>[
                                        Container(
                                          child: ListTile(
                                            dense: true,
                                            contentPadding: EdgeInsets.all(0.0),
                                            title: Text(
                                              _controller.food.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1
                                                  .copyWith(fontSize: 20.0),
                                            ),
                                            subtitle: AmountWidget(
                                              food: _controller.food,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headline2,
                                            ),
                                            trailing: IconButton(
                                              iconSize: 20.0,
                                              onPressed: () =>
                                                  _controller.addToWishList(
                                                      _controller.food),
                                              splashColor:
                                                  Theme.of(context).splashColor,
                                              icon: Icon(
                                                AppIcons.heart_empty_1,
                                                color: Theme.of(context)
                                                    .buttonColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              LocaleKeys.weight_unit.tr(
                                                  namedArgs: {
                                                    'weight':
                                                        '${_controller.food.weight}'
                                                  }),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                            ),
                                            SmoothStarRating(
                                              allowHalfRating: false,
                                              isReadOnly: true,
                                              size: 15.0,
                                              starCount: 5,
                                              rating: _controller.food.rating,
                                              color:
                                                  Theme.of(context).buttonColor,
                                              borderColor:
                                                  Theme.of(context).buttonColor,
                                              spacing: 0.0,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: _appConfig.verticalSpace()),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            InkWell(
                                              onTap:
                                                  _controller.decreaseQuantity,
                                              child: ClipOval(
                                                child: Material(
                                                  color: secondaryColor,
                                                  child: SizedBox(
                                                    width: 25,
                                                    height: 25,
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: whiteColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                width: _appConfig
                                                    .horizontalSpace()),
                                            Text(
                                              '${_controller.quantity}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1
                                                  .copyWith(fontSize: 18.0),
                                            ),
                                            SizedBox(
                                                width: _appConfig
                                                    .horizontalSpace()),
                                            InkWell(
                                              onTap:
                                                  _controller.increaseQuantity,
                                              child: ClipOval(
                                                child: Material(
                                                  color: secondaryColor,
                                                  child: SizedBox(
                                                    width: 25,
                                                    height: 25,
                                                    child: Icon(
                                                      Icons.add,
                                                      color: whiteColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: _appConfig.verticalSpace()),
                                        SizedBox(
                                            height: _appConfig.verticalSpace()),
                                        Text(
                                          LocaleKeys.title_ingrident.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                        Text(
                                          LocaleKeys.subtitle_ingrident.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                        SizedBox(height: _appConfig.bigSpace()),
                                        IngridentGridWidget(
                                          controller: _controller,
                                          ingridents:
                                              _controller.food.ingridents,
                                        ),
                                        SizedBox(
                                            height: _appConfig.verticalSpace()),
                                        Divider(),
                                        SizedBox(
                                            height: _appConfig.verticalSpace()),
                                        Text(
                                          LocaleKeys.title_extra.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                        Text(
                                          LocaleKeys.subtitle_extra.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                        SizedBox(height: _appConfig.bigSpace()),
                                        ExtraListWidget(
                                          controller: _controller,
                                          extras: _controller.food.extras,
                                        ),
                                        Divider(),
                                        TabBarNoRipple(
                                          controller: _tabController,
                                          isScrollable: false,
                                          indicatorColor:
                                              Theme.of(context).buttonColor,
                                          tabs: [
                                            Tab(
                                                text: LocaleKeys
                                                    .title_description
                                                    .tr()),
                                            Tab(
                                                text: LocaleKeys.title_review
                                                    .tr()),
                                          ],
                                        ),
                                        Container(
                                          height: _appConfig.appHeight(20),
                                          child: TabBarView(
                                            controller: _tabController,
                                            physics: PageScrollPhysics(),
                                            children: [
                                              FoodDescriptionWidget(
                                                food: _controller.food,
                                                excerpt: _controller.excerpt,
                                                onExcerptPressed:
                                                    _controller.setExcerpt,
                                              ),
                                              ReviewsListWidget(
                                                reviewsList: _controller
                                                    .food.foodReviews,
                                                onReviewPressed: (review) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: _appConfig.bigSpace()),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        PrimaryButton(
                          width: _appConfig.appWidth(80),
                          text: LocaleKeys.action_add_cart.tr(),
                          onPressed: () =>
                              _controller.addToCart(_controller.food),
                        ),
                      ],
                    ),
                  ),
          ),
          _controller.food == null
              ? Container()
              : Container(
                  color: isShrink
                      ? Theme.of(context).backgroundColor
                      : Colors.transparent,
                  child: SafeArea(
                    child: Container(
                      height: 60.0,
                      child: SliverAppbar(
                        title: _title,
                        isShrink: isShrink,
                        cartCount: _controller.cartCount,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
