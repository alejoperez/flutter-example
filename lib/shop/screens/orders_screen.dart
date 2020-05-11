import 'package:flutter/material.dart';
import 'package:flutterexample/shop/widgets/order_item_view.dart';
import 'package:flutterexample/shop/widgets/shop_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutterexample/providers/orders_provider.dart';

class OrdersScreen extends StatelessWidget {
  static const ROUTE_NAME = "/orders";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Orders"),
        ),
        drawer: ShopDrawer(),
        body: FutureBuilder(
            future: Provider.of<OrdersProvider>(context, listen: false)
                .fetchOrders(),
            builder: (ctx, data) {
              if (data.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (data.error != null) {
                return Center(child: Text("An Error ocurred!"));
              } else {
                return Consumer<OrdersProvider>(
                  builder: (ctx, ordersProvider, _) => ListView.builder(
                      itemCount: ordersProvider.orders.length,
                      itemBuilder: (_, index) =>
                          OrderItemView(ordersProvider.orders[index])),
                );
              }
            }));
  }
}
