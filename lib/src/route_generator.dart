import 'package:flutter/material.dart';
import 'package:food_order/src/view/food/category_food_screen.dart';
import 'package:food_order/src/view/food/food_detail_screen.dart';
import 'package:food_order/src/view/search_screen.dart';

import 'view/language_screen.dart';
import 'view/login_screen.dart';
import 'view/main_screen.dart';
import 'view/splash_screen.dart';
import 'view/walkthrough_screen.dart';

const splashRoute = '/splash';
const walkThroughRoute = '/walkthrough';
const languageRoute = '/language';

const loginRoute = '/user/login';
const profileRoute = '/user/profile';
const myOrderRoute = '/user/order';
const favFoodRoute = '/user/favourite/order';

const homeRoute = '/home';
const searchRoute = '/search';
const mapRoute = '/map';

const menuRoute = '/menu';
const foodRoute = '/food/detail';
const categoryFoodRoute = '/food/category';

const cartRoute = '/Cart';
const checkoutRoute = '/checkout';

const helpRoute = '/help';
const notificationRoute = '/notification';
const settingRoute = '/setting';

// arguments
String arg_current_tab = 'current_tab';
String arg_category = 'category';
String arg_food_id = 'food_id';
String arg_is_cart = 'is_cart';

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
//      case '/MobileVerification':
//        return MaterialPageRoute(builder: (_) => SignUpWidget());
//      case '/MobileVerification2':
//        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginUserScreen());
      case homeRoute:
        return MaterialPageRoute(
            builder: (_) => MainScreen(currentTab: args[arg_current_tab]));
//      case '/Details':
//        return MaterialPageRoute(builder: (_) => DetailsWidget(routeArgument: args as RouteArgument));
//      case '/Map':
//        return MaterialPageRoute(builder: (_) => MapWidget(routeArgument: args as RouteArgument));
//      case '/Menu':
//        return MaterialPageRoute(builder: (_) => MenuWidget(routeArgument: args as RouteArgument));
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
