import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/repository/static_data.dart';
import 'package:food_order/src/utils/api_config.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:http/http.dart';

import '../models/model.dart';
import 'user_repo.dart' as userRepo;

ValueNotifier<int> userCartCount = new ValueNotifier(0);

final _functions = Functions();

Future<List<Cart>> getCart() async {
  await Future.delayed(Duration(seconds: 3));
  Response response = Response(userCartData, 200);
  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    return (result['data'] as List).map((data) => Cart.fromJSON(data)).toList();
  }
}

// Future<Stream<Cart>> getCart() async {
//   final _functions = Functions();
//   User _user = userRepo.currentUser.value;
//   if (_user.apiToken == null) {
//     return new Stream.value(null);
//   }
//   final String url = user_cart_url(_user.apiToken, _user.id);

//   final client = new Client();
//   final streamedRest = await client.send(Request('get', Uri.parse(url)));

//   return streamedRest.stream
//       .transform(utf8.decoder)
//       .transform(json.decoder)
//       .map((data) => _functions.getData(data))
//       .expand((data) => (data as List))
//       .map((data) {
//     return Cart.fromJSON(data);
//   });
// }

Future<void> getCartCount() async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(0);
  }
  Map<String, String> header = _functions.getHeader();
  // final client = new Client();
  // final response = await client.get(
  //   cart_count_url,
  //   headers: header,
  // );
  Response response = Response(cartCountData, 200);
  if (response.statusCode == 200) {
    userCartCount.value = json.decode(response.body)['data'];
    userCartCount.notifyListeners();
  }
}

Future<Map<String, dynamic>> cartCheckout(Order order) async {
  // final client = new Client();
  // final response = await client.post(
  //   cart_count_url,
  //   headers: getHeader(),
  //   body: order.toMap(),
  // );
  Response response = Response(checkoutData, 200);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  }
  return null;
}

Future<Map<String, dynamic>> validateVoucher(String voucher) async {
  Response response = Response(voucherData, 200);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  }
  return null;
}

Future<Cart> addCart(Cart cart, bool reset) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Cart.empty();
  }
  final String resetParam = 'reset=${reset ? 1 : 0}';
  cart.userId = _user.id;
  final String url = user_add_cart_url(resetParam);
  final client = new Client();
  final response = await client.post(
    url,
    headers: _functions.getHeader(),
    body: json.encode(cart.toMap()),
  );
  Map<String, dynamic> decodedJSON;
  try {
    var result = json.decode(response.body);
    decodedJSON = result['data'] as Map<String, dynamic>;
  } on FormatException catch (error) {
    print("The provided string is not valid JSON addCart");
  }
  return Cart.fromJSON(decodedJSON);
}

Future<Cart> updateCart(Cart cart) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Cart.empty();
  }
  cart.userId = _user.id;
  final String url = user_update_cart_url(cart.id);
  final client = new Client();
  final response = await client.put(
    url,
    headers: _functions.getHeader(),
    body: json.encode(cart.toMap()),
  );
  return Cart.fromJSON(json.decode(response.body)['data']);
}

Future<bool> removeCart(Cart cart) async {
  final _functions = Functions();
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return false;
  }
  final String url = user_update_cart_url(cart.id);
  final client = new Client();
  final response = await client.delete(
    url,
    headers: _functions.getHeader(),
  );
  return _functions.getBoolData(json.decode(response.body));
}
