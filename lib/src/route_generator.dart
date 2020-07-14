import 'package:flutter/material.dart';
import 'package:food_order/src/view/food/food_by_category.dart';
import 'package:food_order/src/view/food/food_detail.dart';

import 'view/main_screen.dart';
import 'view/splash_screen.dart';
import 'view/walkthrough_screen.dart';

const splashRoute = '/splash';
const walkThroughRoute = '/walkthrough';
const languageRoute = '/language';

const loginRoute = '/user/login';
const forgotPassRoute = '/user/forgetpassword';

const homeRoute = '/home';
const mapRoute = '/map';
const menuRoute = '/menu';
const foodRoute = '/food';
const categoryFoodRoute = '/category/food';
const cartRoute = '/Cart';

const checkoutRoute = '/checkout';
const settingRoute = '/setting';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
//      case '/Debug':
//        return MaterialPageRoute(builder: (_) => DebugWidget(routeArgument: args as RouteArgument));
      case walkThroughRoute:
        return MaterialPageRoute(builder: (_) => WalkthroughScreen());
      case splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
//      case '/SignUp':
//        return MaterialPageRoute(builder: (_) => SignUpWidget());
//      case '/MobileVerification':
//        return MaterialPageRoute(builder: (_) => SignUpWidget());
//      case '/MobileVerification2':
//        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case loginRoute:
//        return MaterialPageRoute(builder: (_) => LoginWidget());
//      case '/ForgetPassword':
//        return MaterialPageRoute(builder: (_) => ForgetPasswordWidget());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => MainScreen(currentTab: args));
//      case '/Details':
//        return MaterialPageRoute(builder: (_) => DetailsWidget(routeArgument: args as RouteArgument));
//      case '/Map':
//        return MaterialPageRoute(builder: (_) => MapWidget(routeArgument: args as RouteArgument));
//      case '/Menu':
//        return MaterialPageRoute(builder: (_) => MenuWidget(routeArgument: args as RouteArgument));
      case categoryFoodRoute:
        return MaterialPageRoute(
            builder: (_) => FoodByCategory(category: args));

      case foodRoute:
        return MaterialPageRoute(builder: (_) => FoodDetail(food: args));
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
//        return MaterialPageRoute(builder: (_) => LanguagesWidget());
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
