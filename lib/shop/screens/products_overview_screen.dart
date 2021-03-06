import 'package:flutter/material.dart';
import 'package:flutterexample/shop/screens/cart_screen.dart';
import 'package:flutterexample/shop/widgets/bagde_view.dart';
import 'package:flutterexample/providers/shopping_cart_provider.dart';
import 'package:flutterexample/shop/widgets/shop_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutterexample/providers/product_list_provider.dart';
import 'package:flutterexample/shop/widgets/products_grid_view.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  static const ROUTE_NAME = "/products-overview";
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavorite = false;
  var _isInitProducts = false;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitProducts) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductListProvider>(context).fetchProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((_) {
        setState(() {
          _isLoading = false;
        });
      });
      _isInitProducts = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showFavorite = true;
                } else {
                  _showFavorite = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text("Only Favorites"),
                  value: FilterOptions.Favorites),
              PopupMenuItem(child: Text("Show All"), value: FilterOptions.All),
            ],
          ),
          Consumer<ShoppingCartProvider>(
            builder: (_, shoppingCartProvider, iconButton) => Badge(
                child: iconButton,
                value: shoppingCartProvider.cartCount.toString()),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.ROUTE_NAME);
              },
            ),
          )
        ],
      ),
      drawer: ShopDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : ProductsGridView(_showFavorite),
    );
  }
}
