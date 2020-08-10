import 'package:food_order/src/model/order.dart';
import 'package:food_order/src/model/order_status.dart';
import 'package:food_order/src/repository/address_repo.dart';

import 'cart_repo.dart';

getOrder() {
  return Order(
    id: 1,
    foodOrders: getFoodCart(),
    orderStatus: OrderStatus(id: 1, status: 'ordered'),
    tax: 10,
    deliveryFee: 50,
    dateTime: DateTime.now(),
    user: null,
    payment: null,
    deliveryAddress: getAddress(),
  );
}
