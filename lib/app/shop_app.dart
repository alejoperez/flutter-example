import 'package:flutter/material.dart';
import 'package:flutterexample/providers/orders_provider.dart';
import 'package:flutterexample/providers/shopping_cart_provider.dart';
import 'package:flutterexample/shop/screens/cart_screen.dart';
import 'package:flutterexample/shop/screens/edit_new_product_screen.dart';
import 'package:flutterexample/shop/screens/manage_product_screen.dart';
import 'package:flutterexample/shop/screens/orders_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutterexample/shop/screens/product_detail_screen.dart';
import 'package:flutterexample/shop/screens/products_overview_screen.dart';
import 'package:flutterexample/providers/product_list_provider.dart';

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductListProvider()),
        ChangeNotifierProvider(create: (_) => ShoppingCartProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
      ],
      child: MaterialApp(
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.ROUTE_NAME: (_) => ProductDetailScreen(),
          CartScreen.ROUTE_NAME: (_) => CartScreen(),
          OrdersScreen.ROUTE_NAME: (_) => OrdersScreen(),
          ManageProductScreen.ROUTE_NAME: (_) => ManageProductScreen(),
          EditProductScreen.ROUTE_NAME: (_) => EditProductScreen(),
        },
        theme: ThemeData(primarySwatch: Colors.teal, accentColor: Colors.amber),
      ),
    );
  }
}
