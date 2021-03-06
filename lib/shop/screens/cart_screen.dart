import 'package:flutter/material.dart';
import 'package:flutterexample/shop/widgets/cart_item_view.dart';
import 'package:provider/provider.dart';
import 'package:flutterexample/providers/shopping_cart_provider.dart';
import 'package:flutterexample/providers/orders_provider.dart';

class CartScreen extends StatelessWidget {
  static const ROUTE_NAME = "/shopping-cart";

  @override
  Widget build(BuildContext context) {
    final shoppingCart = Provider.of<ShoppingCartProvider>(context);
    return Scaffold(
        appBar: AppBar(title: Text("Shopping Cart")),
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total", style: TextStyle(fontSize: 20)),
                    Spacer(),
                    Chip(
                      label: Text(
                        "\$ ${shoppingCart.totalAmount.toStringAsFixed(2)}",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    OrderButton(shoppingCart: shoppingCart)
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
                child: ListView.builder(
                    itemCount: shoppingCart.shoppingCart.length,
                    itemBuilder: (_, index) => CartItemView(
                          id: shoppingCart.shoppingCart.values
                              .toList()[index]
                              .id,
                          productId:
                              shoppingCart.shoppingCart.keys.toList()[index],
                          title: shoppingCart.shoppingCart.values
                              .toList()[index]
                              .title,
                          price: shoppingCart.shoppingCart.values
                              .toList()[index]
                              .price,
                          quantity: shoppingCart.shoppingCart.values
                              .toList()[index]
                              .quantity,
                        )))
          ],
        ));
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.shoppingCart,
  }) : super(key: key);

  final ShoppingCartProvider shoppingCart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text("ORDER NOW"),
      onPressed: (widget.shoppingCart.totalAmount <= 0 || _isLoading) ? null : ()  async {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<OrdersProvider>(context, listen: false).addOrder(widget.shoppingCart.shoppingCart.values.toList(), widget.shoppingCart.totalAmount);
        setState(() {
          _isLoading = false;
        });
        widget.shoppingCart.clearCart();
      },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
