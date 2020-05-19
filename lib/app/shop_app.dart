import 'package:flutter/material.dart';
import 'package:flutterexample/providers/auth_provider.dart';
import 'package:flutterexample/providers/orders_provider.dart';
import 'package:flutterexample/providers/shopping_cart_provider.dart';
import 'package:flutterexample/shop/helpers/custom_route.dart';
import 'package:flutterexample/shop/screens/auth_screen.dart';
import 'package:flutterexample/shop/screens/cart_screen.dart';
import 'package:flutterexample/shop/screens/edit_new_product_screen.dart';
import 'package:flutterexample/shop/screens/manage_product_screen.dart';
import 'package:flutterexample/shop/screens/orders_screen.dart';
import 'package:flutterexample/shop/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutterexample/shop/screens/product_detail_screen.dart';
import 'package:flutterexample/shop/screens/products_overview_screen.dart';
import 'package:flutterexample/providers/product_list_provider.dart';

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, ProductListProvider>(
          create: (_) => ProductListProvider("","",[]),
          update: (ctx, authProvider, previousProductListProvider) => ProductListProvider(authProvider.token,authProvider.userId, previousProductListProvider.products),
        ),
        ChangeNotifierProvider(create: (_) => ShoppingCartProvider()),
        ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
          create: (_) => OrdersProvider("","",[]),
          update: (ctx, authProvider, previousOrdersProvider) => OrdersProvider(authProvider.token, authProvider.userId, previousOrdersProvider.orders),
        ),
      ],
      child: Consumer<AuthProvider>(
          builder: (ctx, authProvider, _) => MaterialApp(
                home: authProvider.isAuthenticated ? ProductsOverviewScreen() : FutureBuilder(
                  future: authProvider.tryAutoLogin(),
                  builder: (ctx, authSnapshot) => authSnapshot.connectionState == ConnectionState.waiting ? SplashScreen() : ShopAuthScreen(),
                ),
                routes: {
                  ProductDetailScreen.ROUTE_NAME: (_) => ProductDetailScreen(),
                  CartScreen.ROUTE_NAME: (_) => CartScreen(),
                  OrdersScreen.ROUTE_NAME: (_) => OrdersScreen(),
                  ManageProductScreen.ROUTE_NAME: (_) => ManageProductScreen(),
                  EditProductScreen.ROUTE_NAME: (_) => EditProductScreen(),
                },
                theme: ThemeData(
                    primarySwatch: Colors.teal,
                    accentColor: Colors.amber,
                    pageTransitionsTheme: PageTransitionsTheme(
                      builders: {
                        TargetPlatform.android:CustomPageTransitionBuilder(),
                        TargetPlatform.iOS:CustomPageTransitionBuilder(),
                      }
                    )
                ),
          )),
    );
  }
}
