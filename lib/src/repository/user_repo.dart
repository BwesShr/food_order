import 'dart:convert';
import 'dart:io';

import 'package:food_order/src/repository/repository.dart';
import 'package:food_order/src/utils/api_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/utils/constants.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:food_order/src/utils/save_data.dart';
import 'package:http/http.dart';

import '../models/model.dart';

ValueNotifier<User> currentUser = new ValueNotifier(User.empty());
ValueNotifier<Address> deliveryAddress = new ValueNotifier(Address.empty());

final _functions = Functions();

Future<Map<String, dynamic>> loginRequest(User user) async {
  final client = new Client();
  // final response = await client.post(
  //   login_url,
  //   headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //   body: json.encode(user.toMap()),
  // );

  await Future.delayed(Duration(seconds: 3));
  Response response = new Response(loginData, 200);

  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value =
        User.fromJSON(json.decode(response.body)['data']['user']);
    getCartCount();
  }
  return json.decode(response.body);
}

Future<Map<String, dynamic>> registerRequest(User user) async {
  final client = new Client();
  // final response = await client.post(
  //   register_url,
  //   headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //   body: json.encode(user.toMap()),
  // );

  await Future.delayed(Duration(seconds: 3));
  Response response = new Response(registerData, 200);

  if (response.statusCode == 200) {
    currentUser.value =
        User.fromJSON(json.decode(response.body)['data']['user']);
  }
  return json.decode(response.body);
}

Future<Map<String, dynamic>> mobileRequest(User user) async {
  final client = new Client();
  // final response = await client.post(
  //   send_otp_url,
  //   headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //   body: json.encode(user.toMap()),
  // );

  await Future.delayed(Duration(seconds: 3));
  Response response = new Response(sendOtpData, 200);

  if (response.statusCode == 200) {
    currentUser.value.phone = user.phone;
  }
  return json.decode(response.body);
}

Future<Map<String, dynamic>> verifyOtpRequest(Map<String, dynamic> map) async {
  final client = new Client();
  // final response = await client.post(
  //   verify_otp_url,
  //   headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //   body: json.encode(map),
  // );

  await Future.delayed(Duration(seconds: 3));
  Response response = new Response(verifyOtpData, 200);

  if (response.statusCode == 200) {}
  return json.decode(response.body);
}

Future<Map<String, dynamic>> resetPasswordRequest(User user) async {
  final client = new Client();
  // final response = await client.post(
  //   reset_password_url,
  //   headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //   body: json.encode(user.toMap()),
  // );

  await Future.delayed(Duration(seconds: 3));
  Response response = new Response(resetPasswordData, 200);

  if (response.statusCode == 200) {}
  return json.decode(response.body);
}

Future<Map<String, dynamic>> confirmPasswordRequest(
    Map<String, dynamic> map) async {
  final client = new Client();
  // final response = await client.post(
  //   confirm_password_url,
  //   headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //   body: json.encode(map),
  // );

  await Future.delayed(Duration(seconds: 3));
  Response response = new Response(confirmPasswordData, 200);

  if (response.statusCode == 200) {}
  return json.decode(response.body);
}

Future<void> logout() async {
  currentUser.value = new User.empty();
  final saveData = SaveData();
  saveData.removeData(saveData.CURRENT_USER);
}

void setCurrentUser(jsonString) async {
  final saveData = SaveData();
  if (json.decode(jsonString)['data'] != null) {
    saveData.saveString(saveData.CURRENT_USER,
        json.encode(json.decode(jsonString)['data']['user']));
  }
}

// Future<void> setCreditCard(CreditCard creditCard) async {
//   if (creditCard != null) {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('credit_card', json.encode(creditCard.toMap()));
//   }
// }

Future<User> getCurrentUser() async {
  final saveData = SaveData();
  if (await saveData.checkValue(saveData.CURRENT_USER)) {
    currentUser.value = User.fromJSON(
        json.decode(await saveData.getData(saveData.CURRENT_USER)));
    currentUser.value.auth = true;
  } else {
    currentUser.value.auth = false;
  }
  currentUser.notifyListeners();
  return currentUser.value;
}

// Future<CreditCard> getCreditCard() async {
//   CreditCard _creditCard = new CreditCard();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey('credit_card')) {
//     _creditCard =
//         CreditCard.fromJSON(json.decode(await prefs.get('credit_card')));
//   }
//   return _creditCard;
// }

Future<User> update(User user) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  final String url = '${api_base_url}users/${currentUser.value.id}?$_apiToken';
  final client = new Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  setCurrentUser(response.body);
  currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  return currentUser.value;
}

Future<void> getDeliveryAddress() async {
  final _functions = Functions();
  // User _user = userRepo.currentUser.value;
  // Map<String, String> header = {
  //   HttpHeaders.contentTypeHeader: 'application/json',
  //   'Authorization': 'Bearer ${_user.apiToken}'
  // };

  await Future.delayed(Duration(seconds: 3));
  Response response = new Response(deliveryAddressData, 200);

  if (response.statusCode == 200) {
    deliveryAddress.value =
        Address.fromJSON(json.decode(response.body)['data']);
  }
}

getAddress() {
  return new Address(
    id: 1,
    userId: 1,
    fullName: 'Biwesh Shrestha',
    mobile: '9860660020',
    city: 'Lokanthali',
    address: 'Ananda tol, Lokanthali-1, Madhyapur Thimi',
    latitude: 27.672659,
    longitude: 85.361029,
    type: Constants.addressTypeWork,
    isDefault: true,
  );
}

getAddresses() {
  return [
    new Address(
      id: 1,
      userId: 1,
      fullName: 'Biwesh Shrestha',
      mobile: '9860660020',
      city: 'Lokanthali',
      address: 'Ananda tol, Lokanthali-1, Madhyapur Thimi',
      latitude: 27.672659,
      longitude: 85.361029,
      type: Constants.addressTypeHome,
      isDefault: true,
    ),
    new Address(
      id: 2,
      userId: 1,
      fullName: 'Biwesh Shrestha',
      mobile: '9860660020',
      city: 'Chabahil',
      address: 'Charumati Bhawan, Gopikrishana Chowk',
      latitude: 27.672659,
      longitude: 85.361029,
      type: Constants.addressTypeWork,
      isDefault: false,
    ),
  ];
}
// Future<Stream<Address>> getAddresses() async {
// User _user = currentUser.value;
// final String _apiToken = 'api_token=${_user.apiToken}&';
// final String url =
//     '${api_base_url}delivery_addresses?$_apiToken&search=user_id:${_user.id}&searchFields=user_id:=&orderBy=is_default&sortedBy=desc';
// print(url);
// final client = new http.Client();
// final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

// return streamedRest.stream
//     .transform(utf8.decoder)
//     .transform(json.decoder)
//     .map((data) => Helper.getData(data))
//     .expand((data) => (data as List))
//     .map((data) {
//   return Address.fromJSON(data);
// });
// }

Future<Address> addAddress(Address address) async {
  User _user = currentUser.value;
  address.userId = _user.id;
  final String url = '${api_base_url}delivery_addresses';
  final client = new Client();
  final response = await client.post(
    url,
    headers: _functions.getHeader(),
    body: json.encode(address.toMap()),
  );
  return Address.fromJSON(json.decode(response.body)['data']);
}

Future<Address> updateAddress(Address address) async {
  address.userId = currentUser.value.id;
  final String url = '${api_base_url}delivery_addresses/${address.id}';
  final client = new Client();
  final response = await client.put(
    url,
    headers: _functions.getHeader(),
    body: json.encode(address.toMap()),
  );
  return Address.fromJSON(json.decode(response.body)['data']);
}

Future<Address> removeDeliveryAddress(Address address) async {
  final String url = '${api_base_url}delivery_addresses/${address.id}';
  final client = new Client();
  final response = await client.delete(
    url,
    headers: _functions.getHeader(),
  );
  return Address.fromJSON(json.decode(response.body)['data']);
}
