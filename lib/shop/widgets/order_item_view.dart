import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterexample/providers/orders_provider.dart';
import 'package:intl/intl.dart';

class OrderItemView extends StatefulWidget {
  final Order order;

  OrderItemView(this.order);

  @override
  _OrderItemViewState createState() => _OrderItemViewState();
}

class _OrderItemViewState extends State<OrderItemView> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("\$ ${widget.order.amount}"),
            subtitle: Text(
                DateFormat("dd/MM/yyyy hh:mm").format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(10 + (widget.order.shoppingCart.length * 20.0), 100),
              child: ListView.builder(
                itemBuilder: (_, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.order.shoppingCart[index].title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.order.shoppingCart[index].quantity} x \$ ${widget.order.shoppingCart[index].price}",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                itemCount: widget.order.shoppingCart.length,
              ),
            )
        ],
      ),
    );
  }
}
