import 'category.dart';
import 'extra.dart';
import 'media.dart';
import 'nutrition.dart';
import 'restaurant.dart';
import 'review.dart';

class Food {
  int id;
  String name;
  double price;
  double discountPrice;
  Media image;
  String description;
  String ingredients;
  String weight;
  bool featured;
  Restaurant restaurant;
  int category_id;
  List<Extra> extras;
  List<Review> foodReviews;
  List<Nutrition> nutritions;

  Food.empty();
  Food({
    this.id,
    this.name,
    this.price,
    this.discountPrice,
    this.image,
    this.description,
    this.ingredients,
    this.weight,
    this.featured,
    this.restaurant,
    this.category_id,
    this.extras,
    this.foodReviews,
    this.nutritions,
  });

  Food.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      name = jsonMap['name'];
      price = jsonMap['price'] != null ? jsonMap['price'].toDouble() : 0.0;
      discountPrice = jsonMap['discount_price'] != null
          ? jsonMap['discount_price'].toDouble()
          : 0.0;
      description = jsonMap['description'];
      ingredients = jsonMap['ingredients'];
      weight = jsonMap['weight'] != null ? jsonMap['weight'].toString() : '';
      featured = jsonMap['featured'] ?? false;
      restaurant = jsonMap['restaurant'] != null
          ? Restaurant.fromJSON(jsonMap['restaurant'])
          : new Restaurant();
      category_id = jsonMap['category_id'];
      image = jsonMap['media'] != null
          ? Media.fromJSON(jsonMap['media'][0])
          : new Media();
      extras = jsonMap['extras'] != null
          ? List.from(jsonMap['extras'])
              .map((element) => Extra.fromJSON(element))
              .toList()
          : [];
      nutritions = jsonMap['nutrition'] != null
          ? List.from(jsonMap['nutrition'])
              .map((element) => Nutrition.fromJSON(element))
              .toList()
          : [];
      foodReviews = jsonMap['food_reviews'] != null
          ? List.from(jsonMap['food_reviews'])
              .map((element) => Review.fromJSON(element))
              .toList()
          : [];
    } catch (e) {
      //print(jsonMap);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["price"] = price;
    map["discountPrice"] = discountPrice;
    map["description"] = description;
    map["ingredients"] = ingredients;
    map["weight"] = weight;
    return map;
  }

  @override
  bool operator ==(dynamic other) {
    return other.id == this.id;
  }
}
