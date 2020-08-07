import 'package:flutter/material.dart';
import 'package:food_order/src/model/extra.dart';
import 'package:food_order/src/model/review.dart';

import 'ingrident.dart';
import 'media.dart';

class Food {
  int id;
  int categoryId;
  String name;
  double price;
  double discount;
  Media image;
  String excerpt;
  String description;
  String weight;
  bool featured;
  double rating;
  List<Ingrident> ingridents;
  List<Extra> extras;
  List<Review> foodReviews;

  Food.empty();
  Food({
    @required this.id,
    @required this.categoryId,
    @required this.name,
    @required this.price,
    @required this.discount,
    @required this.image,
    @required this.excerpt,
    @required this.description,
    @required this.weight,
    @required this.featured,
    @required this.rating,
    @required this.ingridents,
    @required this.extras,
    @required this.foodReviews,
  });

  Food.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      categoryId = jsonMap['category_id'];
      name = jsonMap['name'];
      price = jsonMap['price'] != null ? jsonMap['price'].toDouble() : 0.0;
      discount = jsonMap['discount'] != null ? jsonMap['discount'] : 0;
      image = jsonMap['media'] != null
          ? Media.fromJSON(jsonMap['media'][0])
          : new Media.empty();
      excerpt = jsonMap['excerpt'];
      description = jsonMap['description'];
      weight = jsonMap['weight'] != null ? jsonMap['weight'].toString() : '';
      featured = jsonMap['featured'] ?? false;
      rating = jsonMap['rating'];
      ingridents = jsonMap['ingredient'] != null
          ? List.from(jsonMap['ingredient'])
              .map((element) => Ingrident.fromJSON(element))
              .toList()
          : [];
      extras = jsonMap['extra'] != null
          ? List.from(jsonMap['extra'])
              .map((element) => Extra.fromJSON(element))
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
    map["category_id"] = categoryId;
    map["name"] = name;
    map["price"] = price;
    map["discount"] = discount;
    map["image"] = image;
    map["excerpt"] = excerpt;
    map["description"] = description;
    map["ingredients"] = ingridents;
    map["weight"] = weight;
    map["featured"] = featured;
    map["rating"] = featured;
    return map;
  }

  @override
  bool operator ==(dynamic other) {
    return other.id == this.id;
  }
}
