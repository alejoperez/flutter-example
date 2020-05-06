import 'package:flutter/material.dart';
import 'package:flutterexample/shop/widgets/order_item_view.dart';
import 'package:flutterexample/shop/widgets/shop_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutterexample/providers/orders_provider.dart';

class OrdersScreen extends StatelessWidget {
  static const ROUTE_NAME = "/orders";
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      drawer: ShopDrawer(),
      body: ListView.builder(
          itemCount: provider.orders.length,
          itemBuilder: (_, index) => OrderItemView(provider.orders[index])),
    );
  }
}
