import 'package:flutter/foundation.dart';
import 'package:flutterexample/providers/shopping_cart_provider.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> shoppingCart;
  final DateTime dateTime;

  const Order(
      {@required this.id,
      @required this.amount,
      @required this.shoppingCart,
      @required this.dateTime});
}

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> shoppingCart, double total) {
    _orders.insert(
        0,
        Order(
            id: DateTime.now().toString(),
            amount: total,
            dateTime: DateTime.now(),
            shoppingCart: shoppingCart));
    notifyListeners();
  }
}
