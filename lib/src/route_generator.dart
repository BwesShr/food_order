import 'package:flutter/material.dart';
import 'package:food_order/src/view/food/category_food_screen.dart';
import 'package:food_order/src/view/food/food_detail_screen.dart';
import 'package:food_order/src/view/search_screen.dart';
import 'package:food_order/src/view/user/user_addresses_screen.dart';
import 'package:food_order/src/view/user/user_wishlist_screen.dart';
import 'package:food_order/src/view/cart/checkout_screen.dart';

import 'view/cart/payment_screen.dart';
import 'view/setting/language_screen.dart';
import 'view/login/login_main_screen.dart';
import 'view/main_screen.dart';
import 'view/splash_screen.dart';
import 'view/user/add_address_screen.dart';
import 'view/walkthrough_screen.dart';

const splashRoute = '/splash';
const walkThroughRoute = '/walkthrough';
const languageRoute = '/language';

const loginRoute = '/user/login';

// const profileRoute = '/user/profile';
// const myOrderRoute = '/user/order';
const wishlistRoute = '/user/wishlist/food';

const homeRoute = '/home';
const searchRoute = '/search';
const mapRoute = '/map';

const menuRoute = '/menu';
const foodRoute = '/food/detail';
const categoryFoodRoute = '/food/category';

const cartRoute = '/Cart';
const checkoutRoute = '/checkout';
const myAddressRoute = '/user/address';
const addAddressRoute = '/user/address/add';
const paymentRoute = '/user/order/payment';

const helpRoute = '/help';
const notificationRoute = '/notification';
const settingRoute = '/setting';

// arguments
String arg_current_tab = 'current_tab';
String arg_category = 'category';
String arg_food_id = 'food_id';
String arg_is_cart = 'is_cart';
String arg_address_id = 'address_id';
String arg_is_checkout = 'is_checkout';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map args = settings.arguments as Map;
    switch (settings.name) {
//      case '/Debug':
//        return MaterialPageRoute(builder: (_) => DebugWidget(routeArgument: args as RouteArgument));
      case walkThroughRoute:
        return MaterialPageRoute(builder: (_) => WalkthroughScreen());
      case splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case searchRoute:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginUserScreen());
      case homeRoute:
        return MaterialPageRoute(
            builder: (_) => MainScreen(currentTab: args[arg_current_tab]));
      case categoryFoodRoute:
        return MaterialPageRoute(
            builder: (_) => CategoryFoodScreen(category: args[arg_category]));

      case foodRoute:
        return MaterialPageRoute(
            builder: (_) => FoodDetailScreen(
                  foodId: args[arg_food_id],
                  isCartItem: args[arg_is_cart],
                ));
//      case '/Category':
//        return MaterialPageRoute(builder: (_) => CategoryWidget(routeArgument: args as RouteArgument));
//      case '/Cart':
//        return MaterialPageRoute(builder: (_) => CartWidget(routeArgument: args as RouteArgument));
//      case '/Tracking':
//        return MaterialPageRoute(builder: (_) => TrackingWidget(routeArgument: args as RouteArgument));
//      case '/Reviews':
//        return MaterialPageRoute(builder: (_) => ReviewsWidget(routeArgument: args as RouteArgument));
//      case '/PaymentMethod':
//        return MaterialPageRoute(builder: (_) => PaymentMethodsWidget());
//      case '/DeliveryAddresses':
//        return MaterialPageRoute(builder: (_) => DeliveryAddressesWidget());
//      case '/Checkout':
//        return MaterialPageRoute(builder: (_) => CheckoutWidget());
//      case '/CashOnDelivery':
//        return MaterialPageRoute(builder: (_) => OrderSuccessWidget(routeArgument: RouteArgument(param: 'Cash on Delivery')));
//      case '/PayOnPickup':
//        return MaterialPageRoute(builder: (_) => OrderSuccessWidget(routeArgument: RouteArgument(param: 'Pay on Pickup')));
//      case '/PayPal':
//        return MaterialPageRoute(builder: (_) => PayPalPaymentWidget(routeArgument: args as RouteArgument));
//      case '/OrderSuccess':
//        return MaterialPageRoute(builder: (_) => OrderSuccessWidget(routeArgument: args as RouteArgument));
      case checkoutRoute:
        return MaterialPageRoute(builder: (_) => CheckoutScreen());
      case paymentRoute:
        return MaterialPageRoute(builder: (_) => PaymentScreen());
      case myAddressRoute:
        return MaterialPageRoute(
            builder: (_) => UserAddressesScreen(
                  isCheckout: args[arg_is_checkout],
                ));
      case addAddressRoute:
        return MaterialPageRoute(
            builder: (_) => AddAddressScreen(
                  addressId: args[arg_address_id],
                ));
      case wishlistRoute:
        return MaterialPageRoute(builder: (_) => UserWishListScreen());
      case languageRoute:
        return MaterialPageRoute(builder: (_) => LanguageScreen());
//      case '/Help':
//        return MaterialPageRoute(builder: (_) => HelpWidget());
//      case '/Settings':
//        return MaterialPageRoute(builder: (_) => SettingsWidget());
//      default:
//        // If there is no such named route in the switch statement, e.g. /third
//        return MaterialPageRoute(builder: (_) => PagesTestWidget(currentTab: 2));
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
