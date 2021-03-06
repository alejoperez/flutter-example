import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterexample/providers/product_provider.dart';
import 'package:flutterexample/providers/auth_provider.dart';
import 'package:flutterexample/providers/shopping_cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutterexample/shop/screens/product_detail_screen.dart';

class ProductItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final shoppingCartProvider =
        Provider.of<ShoppingCartProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage("assets/images/product_holder.png"),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.ROUTE_NAME,
                arguments: product.id);
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
              builder: (_, product, __) => IconButton(
                    color: Theme.of(context).accentColor,
                    icon: Icon(product.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () {
                      product.toggleFavorite(
                          authProvider.token, authProvider.userId);
                    },
                  )),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(fontSize: 10),
          ),
          trailing: IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              shoppingCartProvider.addItem(
                  product.id, product.price, product.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Added item to the cart!"),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                    label: "UNDO",
                    onPressed: () {
                      shoppingCartProvider.removeSingleItem(product.id);
                    }),
              ));
            },
          ),
        ),
      ),
    );
  }
}
