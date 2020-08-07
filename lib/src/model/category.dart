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

  Category.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'],
        name = jsonMap['name'],
        slug = jsonMap['slug'],
        image = jsonMap['media'][0]['url'];
}
