import 'package:flutter/material.dart';
import 'package:flutterexample/providers/product_list_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const ROUTE_NAME = "/product-detail";

  @override
  Widget build(BuildContext context) {
    final String productId = ModalRoute.of(context).settings.arguments;
    final product = Provider.of<ProductListProvider>(context, listen: false)
        .findById(productId);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                product.title,
              ),
              background: Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(height: 10),
            Text(
              "\$ ${product.price}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(height: 10),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                )),
            SizedBox(
              height: 800,
            )
          ]))
        ],
      ),
    );
  }
}
