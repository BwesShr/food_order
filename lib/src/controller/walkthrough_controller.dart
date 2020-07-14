import 'package:food_order/src/utils/save_data.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class WalkthroughController extends ControllerMVC {
//  List<Restaurant> topRestaurants = <Restaurant>[];

  int pageIndex;
  int pageLength;
  final _saveData = SaveData();

  WalkthroughController() {
    pageIndex = 0;
    pageLength = 3;

    _saveData.saveBool(_saveData.APP_FIRST_RUN, false);
    //listenForTopRestaurants();
  }

  void updatePageIndex(int index) {
    pageIndex = index;
  }

  int getPageIndex() {
    return pageIndex;
  }
}
