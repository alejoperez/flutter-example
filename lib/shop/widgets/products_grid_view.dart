import 'package:flutter/material.dart';
import 'package:flutterexample/providers/product_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutterexample/shop/widgets/product_item_view.dart';

class ProductsGridView extends StatelessWidget {
  final bool _showFavorite;

  const ProductsGridView(this._showFavorite);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductListProvider>(context);
    final productsLoaded = _showFavorite ? provider.favoriteProducts : provider.products;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (_, index) => ChangeNotifierProvider.value(
        value: productsLoaded[index],
        child: ProductItemView(),
      ),
      itemCount: productsLoaded.length,
    );
  }
}
