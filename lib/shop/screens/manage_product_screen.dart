import 'package:flutter/material.dart';
import 'package:flutterexample/shop/screens/edit_new_product_screen.dart';
import 'package:flutterexample/shop/widgets/manage_product_item_view.dart';
import 'package:flutterexample/shop/widgets/shop_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutterexample/providers/product_list_provider.dart';

class ManageProductScreen extends StatelessWidget {
  static const ROUTE_NAME = "/mange-products";

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<ProductListProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productListProvider = Provider.of<ProductListProvider>(context);
    return Scaffold(
      drawer: ShopDrawer(),
      appBar: AppBar(
        title: const Text("Manage Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.ROUTE_NAME);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: productListProvider.products.length,
              itemBuilder: (_, index) => ManageProductItemView(
                    id: productListProvider.products[index].id,
                    title: productListProvider.products[index].title,
                    imageUrl: productListProvider.products[index].imageUrl,
                  )),
        ),
      ),
    );
  }
}
