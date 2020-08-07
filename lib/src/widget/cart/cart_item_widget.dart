import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/controller/cart_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/model/cart.dart';
import 'package:food_order/src/route_generator.dart';
import 'package:food_order/src/utils/api_config.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/color_theme.dart';
import 'package:food_order/src/utils/functions.dart';

import '../image_placeholder.dart';

class CartItemWidget extends StatefulWidget {
  CartItemWidget({
    Key key,
    this.controller,
    this.cart,
    this.increment,
    this.decrement,
    this.onDeletePressed,
    this.onWishListPressed,
    this.onCartSelected,
  }) : super(key: key);

  final CartController controller;
  Cart cart;
  VoidCallback increment;
  VoidCallback decrement;
  VoidCallback onWishListPressed;
  VoidCallback onDeletePressed;
  VoidCallback onCartSelected;

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  final _functions = Functions();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        IconSlideAction(
          color: Colors.amber,
          onTap: widget.onWishListPressed,
          iconWidget: Icon(
            AppIcons.heart_empty_1,
            color: whiteColor,
            size: _appConfig.searchIconSize(),
          ),
        ),
        IconSlideAction(
          color: Colors.red,
          onTap: widget.onDeletePressed,
          iconWidget: Icon(
            Icons.delete,
            color: whiteColor,
            size: _appConfig.searchIconSize(),
          ),
        ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: _appConfig.verticalSpace(),
            horizontal: _appConfig.horizontalSpace()),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            _appConfig.containerShadow(),
          ],
        ),
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: widget.onCartSelected,
              child: widget.cart.selected
                  ? Icon(
                      AppIcons.check,
                      color: secondaryColor,
                    )
                  : Icon(AppIcons.circle),
            ),
            SizedBox(width: _appConfig.smallSpace()),
            InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed(foodRoute, arguments: {
                arg_food_id: widget.cart.food.id,
                arg_is_cart: true,
              }),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: Hero(
                  tag: widget.cart.food.image.thumb,
                  child: CachedNetworkImage(
                    height: _appConfig.appWidth(25),
                    width: _appConfig.appWidth(25),
                    fit: BoxFit.cover,
                    imageUrl: widget.cart.food.image.thumb,
                    placeholder: (context, url) => ImagePlaceHolder(),
                    errorWidget: (context, url, error) => ImagePlaceHolder(),
                  ),
                ),
              ),
            ),
            SizedBox(width: _appConfig.smallSpace()),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.cart.food.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        // Wrap(
                        //   children: List.generate(
                        //     widget.cart.extras.length,
                        //     (index) {
                        //       Extra extra = widget.cart.extras[index];
                        //       return Text(
                        //         extra.name + ', ',
                        //         style: Theme.of(context).textTheme.caption,
                        //       );
                        //     },
                        //   ),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              LocaleKeys.amount.tr(namedArgs: {
                                'amount':
                                    '${(widget.cart.food.discount != 0) ? _functions.getDiscountedPrice(widget.cart.food) : widget.cart.food.price}'
                              }),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    color: Theme.of(context).buttonColor,
                                  ),
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(AppIcons.minus),
                                  color: Theme.of(context).hintColor,
                                  onPressed: widget.decrement,
                                ),
                                Text(
                                  widget.cart.quantity.toString(),
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                IconButton(
                                  icon: Icon(AppIcons.add),
                                  color: Theme.of(context).hintColor,
                                  onPressed: widget.increment,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
