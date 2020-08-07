import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/controller/cart_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/model/cart.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/widget/buttons/primary_button.dart';
import 'package:food_order/src/widget/cart/cart_item_widget.dart';
import 'package:food_order/src/widget/cart/empty_cart_widget.dart';
import 'package:food_order/src/widget/progress_dialog.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CartScreen extends StatefulWidget {
  CartScreen({
    Key key,
    this.parentScaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> parentScaffoldKey;

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends StateMVC<CartScreen> {
  CartController _controller;
  _CartScreenState() : super(CartController()) {
    _controller = controller;
  }

  @override
  void initState() {
    _controller.listenForCarts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _controller.refreshCarts,
        child: _controller.isLoading
            ? CartProgressDialog(
                itemCount: _appConfig.appHeight(10).toInt(),
              )
            : _controller.carts.length == 0
                ? EmptyCartWidget(
                    controller: _controller,
                    onCheckPressed: () {
                      setState(() {
                        _controller.isLoading = true;
                      });
                      _controller.listenForCarts();
                    },
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(
                            vertical: _appConfig.verticalSpace(),
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: _controller.carts.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                                height: _appConfig.extraSmallSpace());
                          },
                          itemBuilder: (context, index) {
                            Cart cart = _controller.carts[index];
                            return CartItemWidget(
                              controller: _controller,
                              cart: cart,
                              increment: () =>
                                  _controller.incrementQuantity(cart),
                              decrement: () =>
                                  _controller.decrementQuantity(cart),
                              onDeletePressed: () =>
                                  _controller.removeFromCart(cart),
                              onWishListPressed: () =>
                                  _controller.addToWishList(cart),
                              onCartSelected: () =>
                                  _controller.selectCartItem(cart),
                            );
                          },
                        ),
                      ),
                      _controller.subTotal != 0
                          ? Container(
                              height: 60,
                              padding: EdgeInsets.symmetric(
                                  horizontal: _appConfig.horizontalSpace()),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      RichText(
                                        text: TextSpan(
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: LocaleKeys.delivery_amount
                                                  .tr(),
                                            ),
                                            TextSpan(
                                              text: ': ',
                                            ),
                                            TextSpan(
                                              text: LocaleKeys.amount.tr(
                                                  namedArgs: {
                                                    'amount': _controller
                                                        .deliveryFee
                                                        .toStringAsFixed(0)
                                                  }),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .buttonColor,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  LocaleKeys.total_amount.tr(),
                                            ),
                                            TextSpan(
                                              text: ': ',
                                            ),
                                            TextSpan(
                                              text: LocaleKeys.amount.tr(
                                                  namedArgs: {
                                                    'amount': _controller.total
                                                        .toStringAsFixed(2)
                                                  }),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    color: Theme.of(context)
                                                        .buttonColor,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  PrimaryButton(
                                    width: _appConfig.appWidth(30),
                                    text: LocaleKeys.action_checkout.tr(),
                                    onPressed: _controller.checkOut,
                                  ),
                                ],
                              ),
                            )
                          : Offstage(),
                    ],
                  ),
      ),
    );
  }
}
