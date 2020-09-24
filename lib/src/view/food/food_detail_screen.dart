import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/controller/food_controller.dart';
import 'package:food_order/src/models/route_argument.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/widgets/widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FoodDetailScreen extends StatefulWidget {
  FoodDetailScreen({
    Key key,
    @required this.routeArgument,
  }) : super(key: key);

  final RouteArgument routeArgument;

  @override
  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends StateMVC<FoodDetailScreen>
    with SingleTickerProviderStateMixin {
  FoodController _controller;
  ScrollController _scrollController;
  bool _lastStatus;
  String _title;
  double _imageHeight;
  TabController _tabController;

  _FoodDetailScreenState() : super(FoodController()) {
    _controller = controller;
  }

  @override
  void initState() {
    _lastStatus = true;
    _tabController = TabController(vsync: this, length: 2);
    _tabController.index = 0;

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _title = LocaleKeys.title_product_detail.tr();

    if (widget.routeArgument.isCart) {
      _controller.listenForCartItem(foodId: widget.routeArgument.id);
    } else {
      _controller.listenForFoodItem(widget.routeArgument.id);
    }

    super.initState();
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
    if (isShrink != _lastStatus) {
      setState(() {
        _lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (_imageHeight - kToolbarHeight);
  }

  Future<bool> _onBackPressed() {
    if (_controller.showLoginDialog) {
      setState(() {
        _controller.showLoginDialog = false;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    _imageHeight = _appConfig.appHeight(40);

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _controller.scaffoldKey,
        body: ConnectivityCheck(
          child: _controller.food == null
              ? ProgressDialog()
              : Stack(
                  children: <Widget>[
                    Positioned(
                      child: CachedNetworkImage(
                        imageUrl: _controller.food.media.url == null
                            ? ''
                            : _controller.food.media.url,
                        placeholder: (context, url) => ImagePlaceHolder(),
                        errorWidget: (context, url, error) =>
                            ImagePlaceHolder(),
                        imageBuilder: (context, imageProvider) => Container(
                          height: _appConfig.sliverImageHeight(),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Container(
                              margin: EdgeInsets.only(
                                top: _appConfig.appHeight(40),
                              ),
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
                                        onPressed: _controller.addToWishList,
                                        splashColor:
                                            Theme.of(context).splashColor,
                                        icon: Icon(
                                          AppIcons.heart_empty_1,
                                          color: Theme.of(context).buttonColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        LocaleKeys.weight_unit.tr(namedArgs: {
                                          'weight': '${_controller.food.weight}'
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
                                        color: Theme.of(context).buttonColor,
                                        borderColor:
                                            Theme.of(context).buttonColor,
                                        spacing: 0.0,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: _appConfig.verticalSpace()),
                                  FoodDescriptionWidget(
                                    description: _controller.food.description,
                                  ),
                                  SizedBox(height: _appConfig.verticalSpace()),
                                  ItemQuantityWidget(
                                    quantity: _controller.quantity,
                                    onDecreaseQuantity:
                                        _controller.decreaseQuantity,
                                    onIncreaseQuantity:
                                        _controller.increaseQuantity,
                                  ),
                                  SizedBox(height: _appConfig.verticalSpace()),
                                  SizedBox(height: _appConfig.verticalSpace()),
                                  Text(
                                    LocaleKeys.title_ingrident.tr(),
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text(
                                    LocaleKeys.subtitle_ingrident.tr(),
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  SizedBox(height: _appConfig.bigSpace()),
                                  IngridentGridWidget(
                                    controller: _controller,
                                    ingridents: _controller.food.ingridents,
                                  ),
                                  SizedBox(height: _appConfig.verticalSpace()),
                                  Divider(),
                                  SizedBox(height: _appConfig.verticalSpace()),
                                  Text(
                                    LocaleKeys.title_extra.tr(),
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text(
                                    LocaleKeys.subtitle_extra.tr(),
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  SizedBox(height: _appConfig.bigSpace()),
                                  ExtraListWidget(
                                    controller: _controller,
                                    extras: _controller.food.extras,
                                  ),
                                  Divider(),
                                  // TODO: use tab to display description and reviews

                                  // TabBarNoRipple(
                                  //   controller: _tabController,
                                  //   isScrollable: false,
                                  //   indicatorColor:
                                  //       Theme.of(context).buttonColor,
                                  //   tabs: [
                                  //     Tab(
                                  //         text: LocaleKeys
                                  //             .title_description
                                  //             .tr()),
                                  //     Tab(
                                  //         text: LocaleKeys.title_review
                                  //             .tr()),
                                  //   ],
                                  // ),
                                  // Container(
                                  //   height: _appConfig.appHeight(20),
                                  //   child: TabBarView(
                                  // controller: _tabController,
                                  // physics: PageScrollPhysics(),
                                  // children: [
                                  //       ReviewsListWidget(
                                  //         reviewsList: _controller
                                  //             .food.foodReviews,
                                  //         onReviewPressed: (review) {},
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  SizedBox(height: _appConfig.bigSpace()),
                                ],
                              ),
                            ),
                          ),
                        ),
                        PrimaryButton(
                          width: _appConfig.appWidth(80),
                          text: LocaleKeys.action_add_cart.tr(),
                          onPressed: () {
                            if (currentUser.value.auth)
                              _controller.addToCart();
                            else
                              setState(() {
                                _controller.showLoginDialog = true;
                              });
                          },
                        ),
                      ],
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
                                  cartCount: userCartCount.value,
                                ),
                              ),
                            ),
                          ),
                    _controller.showLoginDialog
                        ? MessageWidget(
                            message: LocaleKeys.subtitle_login_register.tr(),
                            buttonText: LocaleKeys.action_login_register.tr(),
                            onButtonClicked: _controller.userLogin,
                          )
                        : Offstage(),
                  ],
                ),
        ),
      ),
    );
  }
}
