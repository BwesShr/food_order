import 'media.dart';

class User {
  int id;
  String fname;
  String lname;
  String email;
  String password;
  String apiToken;
  String deviceToken;
  String phone;
  String address;
  Media image;

  // used for indicate if client logged in or not
  bool auth;

//  String role;

  User.empty();
  User({
    this.id,
    this.fname,
    this.lname,
    this.email,
    this.password,
    this.apiToken,
    this.deviceToken,
    this.phone,
    this.address,
    this.image,
  });

  User.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    fname = jsonMap['first_name'];
    lname = jsonMap['last_name'];
    email = jsonMap['email'];
    apiToken = jsonMap['api_token'];
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

    image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0
        ? Media.fromJSON(jsonMap['media'][0])
        : new Media.empty();
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['email'] = email;
    map['fname'] = fname;
    map['lname'] = lname;
    map['password'] = password;
    map['api_token'] = apiToken;
    if (deviceToken != null) {
      map['device_token'] = deviceToken;
    }
    map['phone'] = phone;
    map['address'] = address;
    map['media'] = image?.toMap();
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map['auth'] = this.auth;
    return map.toString();
  }
}
