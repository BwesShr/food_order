import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category {
  int id;
  String name;
  String slug;
  String image;

  Category.empty();

  Category({
    @required this.id,
    @required this.name,
    @required this.slug,
    @required this.image,
  });

  factory Category.fromJSON(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        slug: json["slug"] == null ? null : json["slug"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "slug": slug == null ? null : slug,
        "name": name == null ? null : name,
        "image": image == null ? null : image,
      };
}
