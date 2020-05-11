import 'package:flutter/foundation.dart';
import 'package:flutterexample/providers/shopping_cart_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> fetchOrders() async {
    final url = "https://test-pn-4be48.firebaseio.com/orders.json";
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;

    final List<Order> orders = [];
    if(data != null) {
      data.forEach((id, data) {
        orders.add(Order(
          id: id,
          amount: data["amount"],
          dateTime: DateTime.parse(data["dateTime"]),
          shoppingCart: (data["products"] as List<dynamic>).map((item) => CartItem(
            id: item["id"],
            title: item["title"],
            price: item["price"],
            quantity: item["quantity"],
          )).toList()
        ));
      });
    }
    _orders = orders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> shoppingCart, double total) async {
    final timeStamp = DateTime.now();
    final url = "https://test-pn-4be48.firebaseio.com/orders.json";
    final response = await http.post(url,
        body: json.encode({
          "amount": total,
          "dateTime": timeStamp.toIso8601String(),
          "products": shoppingCart
              .map((item) => {
                    "id": item.id,
                    "title": item.title,
                    "quantity": item.quantity,
                    "price": item.price
                  })
              .toList()
        }));

    _orders.insert(
        0,
        Order(
            id: json.decode(response.body)["name"],
            amount: total,
            dateTime: timeStamp,
            shoppingCart: shoppingCart));
    notifyListeners();
  }
}
