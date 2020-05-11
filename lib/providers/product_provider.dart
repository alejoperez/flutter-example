import 'package:flutter/foundation.dart';
import 'package:flutterexample/domain/http_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  void setFavoriteValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    final oldStatus = isFavorite;
    setFavoriteValue(!isFavorite);

    try {
      final url = "https://test-pn-4be48.firebaseio.com/products/$id.json";
      final response = await http.patch(url, body: json.encode({ "isFavorite": isFavorite }));
      
      if(response.statusCode >= 400) {
        setFavoriteValue(oldStatus);
        throw HttpException("Could not set favorite");
      }
    } catch(error) {
      setFavoriteValue(oldStatus);
    }

  }
}
