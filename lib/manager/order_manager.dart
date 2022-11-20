import 'package:flutter/cupertino.dart';

import '../services/order_service.dart';
import '../models/order_item.dart';
import '../models/auth_token.dart';

class OrdersManager with ChangeNotifier {
  List<OrderItem> _orders = [];
  final OrdersService _ordersService;
  
  int get orderCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders.reversed];
  }

  OrdersManager([AuthToken? authToken])
    : _ordersService = OrdersService(authToken);

  set authToken (AuthToken? authToken) {
    _ordersService.authToken = authToken;
  }

  Future<void> fetchOrders([bool filterByUser = false]) async {
    _orders = await _ordersService.fetchOrders(filterByUser);
    notifyListeners();
  }

  Future<void> addOrder(OrderItem order) async {
    final newOrder = await _ordersService.addOrder(order);
    if (newOrder != null) {
      _orders.add(newOrder);
      notifyListeners();
    }
  }
}

//  _orders.insert(
//       0,
//       OrderItem(
//         id: 'o${DateTime.now().toIso8601String()}',
//         amount: total,
//         products: cartProducts,
//         dateTime: DateTime.now()
//       ),
//     );