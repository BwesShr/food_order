import 'dart:convert';

import 'package:flutter/material.dart';

Walkthrough walkthroughFromMap(String str) =>
    Walkthrough.fromMap(json.decode(str));

String walkthroughToMap(Walkthrough data) => json.encode(data.toMap());

class Walkthrough {
  String title;
  String subtitle;
  String image;
  String backgroundImage;

  Walkthrough.empty();

  Walkthrough({
    @required this.title,
    @required this.subtitle,
    @required this.image,
    @required this.backgroundImage,
  });

  factory Walkthrough.fromMap(Map<String, dynamic> json) => Walkthrough(
        title: json['title'] == null ? '' : json['title'],
        subtitle: json['subtitle'] == '' ? null : json['subtitle'],
        image: json['image'] == null ? '' : json['image'],
        backgroundImage:
            json['background_image'] == null ? '' : json['background_image'],
      );

  Map<String, dynamic> toMap() => {
        'title': title == null ? '' : title,
        'subtitle': subtitle == null ? '' : subtitle,
        'image': image == null ? '' : image,
        'background_image': backgroundImage == null ? '' : backgroundImage,
      };
}
