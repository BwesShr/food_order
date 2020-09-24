import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'media.dart';

class Restaurant {
  String id;
  String name;
  Media image;
  String rate;
  String address;
  String description;
  String phone;
  String mobile;
  String information;
  double deliveryFee;
  double adminCommission;
  String latitude;
  String longitude;
  double distance;

  Restaurant.empty();

  Restaurant({
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.rate,
    @required this.address,
    @required this.description,
    @required this.phone,
    @required this.mobile,
    @required this.information,
    @required this.deliveryFee,
    @required this.adminCommission,
    @required this.latitude,
    @required this.longitude,
    @required this.distance,
  });

  Restaurant.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    name = jsonMap['name'];
    image =
        jsonMap['media'] != null ? Media.fromJSON(jsonMap['media'][0]) : null;
    rate = jsonMap['rate'] ?? '0';
    deliveryFee = jsonMap['delivery_fee'] != null
        ? double.tryParse(jsonMap['delivery_fee'])
        : 0.0;
    adminCommission = jsonMap['admin_commission'] != null
        ? double.tryParse(jsonMap['admin_commission'])
        : 0.0;
    address = jsonMap['address'];
    description = jsonMap['description'];
    phone = jsonMap['phone'];
    mobile = jsonMap['mobile'];
    information = jsonMap['information'];
    latitude = jsonMap['latitude'];
    longitude = jsonMap['longitude'];
    distance = jsonMap['distance'] != null
        ? double.tryParse(jsonMap['distance'])
        : 0.0;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'delivery_fee': deliveryFee,
      'distance': distance,
    };
  }
}
