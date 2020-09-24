import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User {
  int id;
  String name;
  String email;
  String password;
  String apiToken;
  String deviceToken;
  String phone;
  String address;
  String image;

  // used for indicate if client logged in or not
  bool auth;
//  String role;

  User.empty();

  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.phone,
    @required this.address,
    @required this.image,
    this.password,
    this.apiToken,
    this.deviceToken,
  });

  User.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
    email = jsonMap['email'];
    apiToken = jsonMap['token'];
    deviceToken = jsonMap['device_token'];
    try {
      phone = jsonMap['custom_fields']['phone']['view'];
    } catch (e) {
      phone = '';
    }
    try {
      address = jsonMap['custom_fields']['address']['view'];
    } catch (e) {
      address = '';
    }

    image = jsonMap['image'];
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['email'] = email;
    map['name'] = name;
    map['password'] = password;
    map['api_token'] = apiToken;
    if (deviceToken != null) {
      map['device_token'] = deviceToken;
    }
    map['phone'] = phone;
    map['address'] = address;
    map['image'] = image;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map['auth'] = this.auth;
    return map.toString();
  }
}
