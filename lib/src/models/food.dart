import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model.dart';

class Food {
  int id;
  int categoryId;
  String name;
  double price;
  double discount;
  Media media;
  String description;
  String weight;
  bool featured;
  double rating;
  List<Ingrident> ingridents;
  List<Ingrident> extras;
  List<Review> foodReviews;

  Food.empty();

  Food({
    @required this.id,
    @required this.categoryId,
    @required this.name,
    @required this.price,
    @required this.discount,
    @required this.media,
    @required this.description,
    @required this.weight,
    @required this.featured,
    @required this.rating,
    @required this.ingridents,
    @required this.extras,
    @required this.foodReviews,
  });

  factory Food.fromJSON(Map<String, dynamic> json) {
    return Food(
      id: json["id"] == null ? null : json["id"],
      categoryId: json["category_id"] == null ? null : json["category_id"],
      name: json["name"] == null ? null : json["name"],
      price: json["price"] == null ? 0.0 : json["price"].toDouble(),
      discount: json["discount"] == null ? 0.0 : json["discount"].toDouble(),
      description: json["description"] == null ? null : json["description"],
      weight: json["weight"] == null ? null : json["weight"],
      featured: json["featured"] == null ? null : json["featured"],
      rating: json["rating"] == null ? 0.0 : json["rating"].toDouble(),
      media: json["media"] == null ? null : Media.fromJSON(json["media"]),
      ingridents: json["ingridents"] == null
          ? null
          : List<Ingrident>.from(
              json["ingridents"].map((data) => Ingrident.fromJSON(data))),
      extras: json["extras"] == null
          ? null
          : List<Ingrident>.from(
              json["extras"].map((data) => Ingrident.fromJSON(data))),
      foodReviews: json["review"] == null
          ? null
          : List<Review>.from(
              json["review"].map((data) => Review.fromJSON(data))),
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "category_id": categoryId == null ? null : categoryId,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "discount": discount == null ? null : discount,
        "description": description == null ? null : description,
        "weight": weight == null ? null : weight,
        "featured": featured == null ? null : featured,
        "rating": rating == null ? null : rating,
        "media": media == null ? null : media.toMap(),
        "ingridents": ingridents == null
            ? null
            : List<dynamic>.from(ingridents.map((data) => data.toMap())),
        "extras": extras == null
            ? null
            : List<dynamic>.from(extras.map((data) => data.toMap())),
        "review": foodReviews == null
            ? null
            : List<dynamic>.from(foodReviews.map((data) => data.toMap())),
      };
}
