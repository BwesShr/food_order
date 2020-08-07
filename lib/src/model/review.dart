import 'food.dart';
import 'restaurant.dart';
import 'user.dart';

class Review {
  int id;
  String review;
  double rate;
  User user;

  Review.empty();
  Review({
    this.id,
    this.review,
    this.rate,
    this.user,
  });

  Review.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    review = jsonMap['review'];
    rate = jsonMap['rate'].toDouble() ?? 0.0;
    user = jsonMap['user'] != null ? User.fromJSON(jsonMap['user']) : null;
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["review"] = review;
    map["rate"] = rate;
    map["user_id"] = user?.id;
    return map;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }

  Map ofRestaurantToMap(Restaurant restaurant) {
    var map = this.toMap();
    map["restaurant_id"] = restaurant.id;
    return map;
  }

  Map ofFoodToMap(Food food) {
    var map = this.toMap();
    map["food_id"] = food.id;
    return map;
  }
}
