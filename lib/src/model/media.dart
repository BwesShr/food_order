import 'package:flutter/material.dart';

class Media {
  int id;
  String url;
  String thumb;
  String icon;

  Media.empty() {
    url = '';
    thumb = '';
    icon = '';
  }

  Media({
    @required this.id,
    @required this.url,
    @required this.thumb,
    @required this.icon,
  });

  Media.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      url = jsonMap['url'];
      thumb = jsonMap['thumb'];
      icon = jsonMap['icon'];
    } catch (e) {
      //print(jsonMap);
    }
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['url'] = url;
    map['thumb'] = thumb;
    map['icon'] = icon;
    return map;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}
