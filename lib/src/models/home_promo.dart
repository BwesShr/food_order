import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePromo {
  int id;
  String image;
  String url;

  HomePromo({
    @required this.id,
    @required this.image,
    @required this.url,
  });

  factory HomePromo.fromJSON(Map<String, dynamic> json) => HomePromo(
        id: json["id"] == null ? null : json["id"],
        image: json["image"] == null ? null : json["image"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toMap() => {
        'id': id == null ? null : id,
        'image': image == null ? null : image,
        'url': url == null ? null : url,
      };
}
