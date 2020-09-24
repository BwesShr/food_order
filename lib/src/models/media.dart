import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Media {
  int id;
  String url;
  String thumb;
  String icon;

  Media.empty();

  Media({
    @required this.id,
    @required this.url,
    @required this.thumb,
    @required this.icon,
  });

  factory Media.fromJSON(Map<String, dynamic> json) => Media(
        id: json["id"] == null ? null : json["id"],
        url: json["url"] == null ? null : json["url"],
        thumb: json["thumb"] == null ? null : json["thumb"],
        icon: json["icon"] == null ? null : json["icon"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "url": url == null ? null : url,
        "thumb": thumb == null ? null : thumb,
        "icon": icon == null ? null : icon,
      };

  @override
  String toString() {
    return this.toMap().toString();
  }
}
