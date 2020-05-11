import 'package:flutter/material.dart';
import 'package:flutterexample/domain/http_exception.dart';
import 'package:flutterexample/providers/product_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductListProvider with ChangeNotifier {
  List<Product> _products = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get products {
    return [..._products];
  }

  List<Product> get favoriteProducts {
    return _products.where((product) => product.isFavorite).toList();
  }

  Future<void> fetchProducts() async {
    try {
      const url = "https://test-pn-4be48.firebaseio.com/products.json";
      final response = await http.get(url);
      final decodedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> products = [];

      if (decodedData != null) {
        decodedData.forEach((id, data) {
          products.add(Product(
            id: id,
            title: data["title"],
            description: data["description"],
            price: data["price"],
            imageUrl: data["imageUrl"],
            isFavorite: data["isFavorite"],
          ));
        });
      }

      _products = products;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      const url = "https://test-pn-4be48.firebaseio.com/products.json";
      final response = await http.post(url,
          body: json.encode({
            "title": product.title,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
            "isFavorite": product.isFavorite
          }));
      final newProduct = Product(
        id: json.decode(response.body)["name"],
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
      );
      _products.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      final index = _products.indexWhere((p) => p.id == product.id);
      if (index >= 0) {
        final url =
            "https://test-pn-4be48.firebaseio.com/products/${product.id}.json";
        await http.patch(url,
            body: json.encode({
              "title": product.title,
              "description": product.description,
              "price": product.price,
              "imageUrl": product.imageUrl
            }));

        _products[index] = product;
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteProduct(String id) async {
    final existingIndex = _products.indexWhere((p) => p.id == id);
    var existingProduct = _products[existingIndex];
    _products.removeAt(existingIndex);
    notifyListeners();

    final url = "https://test-pn-4be48.firebaseio.com/products/$id.json";
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _products.insert(existingIndex, existingProduct);
      notifyListeners();
      throw HttpException("Could not load products");
    } else {
      existingProduct = null;
    }
  }

  Product findById(String id) =>
      _products.firstWhere((product) => product.id == id);
}
