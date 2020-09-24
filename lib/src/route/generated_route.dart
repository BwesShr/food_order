import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/view/help_screen.dart';

import '../view/food/category_food_screen.dart';
import '../view/food/food_detail_screen.dart';
import '../view/search_screen.dart';
import '../view/user/user_addresses_screen.dart';
import '../view/user/user_wishlist_screen.dart';
import '../view/food/cart/checkout_screen.dart';
import '../view/food/cart/payment_screen.dart';
import '../view/setting/language_screen.dart';
import '../view/login/login_main_screen.dart';
import '../view/main_screen.dart';
import '../view/setting/setting_screen.dart';
import '../view/splash_screen.dart';
import '../view/user/add_address_screen.dart';
import '../view/user/user_order_screen.dart';
import '../view/walkthrough_screen.dart';

/// page router
const splashRoute = '/splash';
const walkThroughRoute = '/walkthrough';
const homeRoute = '/home';
const searchRoute = '/search';

/// food router
const foodRoute = '/food/detail';
const categoryFoodRoute = '/food/category';
const cartRoute = '/Cart';
const checkoutRoute = '/checkout';
const paymentRoute = '/user/order/payment';

// user router
const loginRoute = '/user/login';
const myOrderRoute = '/user/order';
const wishlistRoute = '/user/wishlist';

const myAddressRoute = '/user/address';
const addAddressRoute = '/user/address/add';

/// setting router
const languageRoute = '/language';
const helpRoute = '/help';
const settingRoute = '/setting';

Route generatedRoute(RouteSettings settings) {
  String routeName = settings.name;
  switch (routeName) {
    case walkThroughRoute:
      return pageRouteBuilder(settings, WalkthroughScreen());
    case splashRoute:
      return pageRouteBuilder(settings, SplashScreen());
    case searchRoute:
      return pageRouteBuilder(settings, SearchScreen());
    case loginRoute:
      return pageRouteBuilder(settings, LoginUserScreen());
    case homeRoute:
      return pageRouteBuilder(
          settings, MainScreen(currentTab: settings.arguments));
    case categoryFoodRoute:
      return pageRouteBuilder(
          settings, CategoryFoodScreen(routeArgument: settings.arguments));
    case foodRoute:
      return pageRouteBuilder(
          settings, FoodDetailScreen(routeArgument: settings.arguments));
    //      case '/Tracking':
    //        return pageRouteBuilder(settings,TrackingWidget(routeArgument: args as RouteArgument));
    //      case '/Reviews':
    //        return pageRouteBuilder(settings,ReviewsWidget(routeArgument: args as RouteArgument));
    //        return pageRouteBuilder(settings,OrderSuccessWidget(routeArgument: RouteArgument(param: 'Pay on Pickup')));
    //      case '/PayPal':
    //        return pageRouteBuilder(settings,PayPalPaymentWidget(routeArgument: args as RouteArgument));
    //      case '/OrderSuccess':
    //        return pageRouteBuilder(settings,OrderSuccessWidget(routeArgument: args as RouteArgument));
    case checkoutRoute:
      return pageRouteBuilder(settings, CheckoutScreen());
    case paymentRoute:
      return pageRouteBuilder(settings, PaymentScreen());
    case myAddressRoute:
      return pageRouteBuilder(settings, UserAddressesScreen());
    case addAddressRoute:
      return pageRouteBuilder(
          settings, AddAddressScreen(routeArgument: settings.arguments));
    case myOrderRoute:
      return pageRouteBuilder(settings, UserOrderScreen());
    case wishlistRoute:
      return pageRouteBuilder(settings, UserWishListScreen());
    case languageRoute:
      return pageRouteBuilder(settings, LanguageScreen());
    case helpRoute:
      return pageRouteBuilder(settings, HelpScreen());
    case settingRoute:
      return pageRouteBuilder(settings, SettingScreen());
    default:
      return pageRouteBuilder(settings, MainScreen(currentTab: 0));
  }
}

PageRouteBuilder pageRouteBuilder(RouteSettings settings, Widget page) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, anotherAnimation) {
      return page;
    },
    transitionDuration: Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, anotherAnimation, child) {
      animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
      return SlideTransition(
        position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(animation),
        child: child,
      );
    },
  );
}
