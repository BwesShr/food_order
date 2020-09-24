import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/controller/checkout_controller.dart';
import 'package:food_order/src/models/model.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/functions.dart';
import 'package:food_order/src/utils/validation.dart';
import 'package:food_order/src/widgets/widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({Key key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends StateMVC<CheckoutScreen> {
  CheckoutController _controller;
  final _voucherController = TextEditingController();
  final _functions = Functions();

  _CheckoutScreenState() : super(CheckoutController()) {
    _controller = controller;
  }

  @override
  void dispose() {
    _voucherController.dispose();
    super.dispose();
  }

  Future<bool> _onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return SafeArea(
      child: Scaffold(
        key: _controller.scaffoldKey,
        appBar: Appbar(
          title: LocaleKeys.title_checkout.tr(),
          onBackPressed: _onBackPressed,
        ),
        body: ConnectivityCheck(
          child: _controller.isLoading
              ? ProgressDialog()
              : Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          deliveryAddress.value == null
                              ? AddAddressButton(
                                  onAddAddressPressed:
                                      _controller.changeAddress,
                                )
                              : UserAddressWidget(
                                  icon: _controller.addressIcon(),
                                  fullName: deliveryAddress.value.fullName,
                                  address: _controller.getLocation(),
                                  onChangeAddressPressed:
                                      _controller.changeAddress,
                                ),
                          SizedBox(height: _appConfig.smallSpace()),
                          Divider(),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _controller.carts.length,
                            padding: EdgeInsets.symmetric(
                              horizontal: _appConfig.horizontalSpace(),
                              vertical: _appConfig.verticalSpace(),
                            ),
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemBuilder: (context, index) {
                              Cart cart = _controller.carts[index];
                              return Row(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    child: Hero(
                                      tag: cart.food.media.thumb,
                                      child: CachedNetworkImage(
                                        height: _appConfig.appWidth(25),
                                        width: _appConfig.appWidth(25),
                                        fit: BoxFit.cover,
                                        imageUrl: cart.food.media.thumb,
                                        placeholder: (context, url) =>
                                            ImagePlaceHolder(),
                                        errorWidget: (context, url, error) =>
                                            ImagePlaceHolder(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: _appConfig.smallSpace()),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          cart.food.name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              LocaleKeys.amount_unit
                                                  .tr(namedArgs: {
                                                'amount':
                                                    '${(cart.food.discount != 0) ? _functions.getDiscountedPrice(cart.food) : cart.food.price}'
                                              }),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .accentColor),
                                            ),
                                            Text(
                                              LocaleKeys.quantity_unit.tr(
                                                  namedArgs: {
                                                    'quantity':
                                                        cart.quantity.toString()
                                                  }),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .accentColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          Divider(thickness: _appConfig.extraSmallSpace()),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: _appConfig.horizontalSpace(),
                              vertical: _appConfig.verticalSpace(),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      TextFormField(
                                        controller: _voucherController,
                                        keyboardType: TextInputType.text,
                                        validator: textValidator,
                                        textInputAction: TextInputAction.done,
                                        onChanged: (input) => setState(() {}),
                                        decoration: InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.auto,
                                          hintText:
                                              LocaleKeys.hint_voucher.tr(),
                                          hintStyle: TextStyle(
                                            color: Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.7),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal:
                                                _appConfig.horizontalSpace(),
                                            vertical:
                                                _appConfig.extraSmallSpace(),
                                          ),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder(),
                                        ),
                                      ),
                                      _controller.voucherMessage != null
                                          ? Text(
                                              _controller.voucherMessage,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(color: Colors.red),
                                            )
                                          : Offstage(),
                                    ],
                                  ),
                                ),
                                SizedBox(width: _appConfig.extraSmallSpace()),
                                PrimaryButton(
                                  width: _appConfig.appWidth(30),
                                  text: LocaleKeys.action_apply.tr(),
                                  color: _voucherController.text.length == 0
                                      ? Theme.of(context).focusColor
                                      : Theme.of(context).buttonColor,
                                  onPressed: () {
                                    setState(() {
                                      _controller.isVoucherLoading = true;
                                    });
                                    _controller.voucher =
                                        _voucherController.text;
                                    _controller.checkVoucher();
                                  },
                                )
                              ],
                            ),
                          ),
                          Divider(thickness: _appConfig.extraSmallSpace()),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: _appConfig.horizontalSpace(),
                              vertical: _appConfig.verticalSpace(),
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      LocaleKeys.subtotal_unit.tr(namedArgs: {
                                        'item':
                                            _controller.carts.length.toString()
                                      }),
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                    Text(
                                      LocaleKeys.amount_unit.tr(namedArgs: {
                                        'amount': _controller.subTotal
                                            .toStringAsFixed(2)
                                      }),
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ],
                                ),
                                SizedBox(height: _appConfig.smallSpace()),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      LocaleKeys.delivery_amount_unit.tr(),
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                    Text(
                                      LocaleKeys.amount_unit.tr(namedArgs: {
                                        'amount': _controller.deliveryFee
                                            .toStringAsFixed(2)
                                      }),
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ],
                                ),

                                // TODO: display VAT detail
                                // SizedBox(height: _appConfig.smallSpace()),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: <Widget>[
                                //     Text(
                                //       LocaleKeys.vat_unit.tr(namedArgs: {
                                //         'vat': _controller.vat.toString()
                                //       }),
                                //       style: Theme.of(context)
                                //           .textTheme
                                //           .subtitle2,
                                //     ),
                                //     Text(
                                //       LocaleKeys.amount_unit.tr(namedArgs: {
                                //         'amount': _controller.taxAmount
                                //             .toStringAsFixed(2)
                                //       }),
                                //       style: Theme.of(context)
                                //           .textTheme
                                //           .subtitle2,
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CheckoutFooter(
                      deliveryFee: _controller.deliveryFee.toStringAsFixed(0),
                      vat: _controller.vat.toString(),
                      total: _controller.total.toStringAsFixed(2),
                      buttonText: LocaleKeys.action_proceed.tr(),
                      onButtonClick: _controller.proceedPayment,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
