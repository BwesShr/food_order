import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/models/model.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:food_order/src/route/generated_route.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ProfileController extends ControllerMVC {
  User user = new User.empty();
  List<Order> recentOrders = [];
  GlobalKey<ScaffoldState> scaffoldKey;
  final _functions = Functions();

  ProfileController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForRecentOrders();
  }

  Future<void> refreshProfile() async {
    recentOrders.clear();
    listenForRecentOrders(
        message: LocaleKeys.orders_refreshed_successfuly.tr());
  }

  void listenForRecentOrders({String message}) async {
    // final Stream<Order> stream = await getRecentOrders();
    // stream.listen((Order _order) {
    //   setState(() {
    //     recentOrders.add(_order);
    //   });
    // }, onError: (a) {
    //   print(a);
    //   scaffoldKey?.currentState?.showSnackBar(SnackBar(
    //     content: Text(LocaleKeys.verify_internet_connection.tr()),
    //   ));
    // }, onDone: () {
    //   if (message != null) {
    //     scaffoldKey.currentState?.showSnackBar(SnackBar(
    //       content: Text(message),
    //     ));
    //   }
    // });
  }

  void myAddress() => Navigator.of(context).pushNamed(myAddressRoute);

  void editProfile() {}

  void wishList() => Navigator.of(context).pushNamed(wishlistRoute);

  void myOrders() {
    Navigator.of(context).pushNamed(myOrderRoute);
  }

  void userLogin() async {
    final message = await Navigator.of(context).pushNamed(loginRoute);
    setState(() {
      _functions.showMessageWithAction(scaffoldKey, context, message);
    });
  }

  void userLogout() {
    logout().then((value) {
      _functions.showMessageWithAction(
          scaffoldKey, context, LocaleKeys.logout_message.tr());
      setState(() {
        currentUser.value.auth = false;
      });
    });
  }
}
