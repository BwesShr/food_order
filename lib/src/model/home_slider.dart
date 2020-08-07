import 'package:flutter/material.dart';

class HomeSlider {
  int id;
  String image;
  String url;

  HomeSlider.empty();

  HomeSlider({
    @required this.id,
    @required this.image,
    @required this.url,
  });

  HomeSlider.fromMap(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'];
    image = json['image'] == null ? null : json['image'];
    url = json['url'] == null ? null : json['url'];
  }

  Map<String, dynamic> toMap() => {
        'id': id == null ? null : id,
        'image': image == null ? null : image,
        'url': url == null ? null : url,
      };
}
