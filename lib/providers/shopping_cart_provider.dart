import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class ShoppingCartProvider with ChangeNotifier {
  Map<String, CartItem> _shoppingCart = {};

  Map<String, CartItem> get shoppingCart {
    return {..._shoppingCart};
  }

  int get cartCount => _shoppingCart.length;

  double get totalAmount {
    double total = 0.0;
    _shoppingCart.forEach((_, cartItem) {
      total += cartItem.quantity * cartItem.price;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_shoppingCart.containsKey(productId)) {
      _shoppingCart.update(
          productId,
          (existing) => CartItem(
              id: existing.id,
              title: existing.title,
              price: existing.price,
              quantity: existing.quantity + 1));
    } else {
      _shoppingCart.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _shoppingCart.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _shoppingCart = {};
    notifyListeners();
  }

}
