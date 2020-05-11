import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterexample/shop/screens/edit_new_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutterexample/providers/product_list_provider.dart';

class ManageProductItemView extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const ManageProductItemView({@required this.id, @required this.title, @required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).pushNamed(EditProductScreen.ROUTE_NAME, arguments: id);
                    },
                    color: Theme.of(context).primaryColor),
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      try {
                        await Provider.of<ProductListProvider>(context, listen: false).deleteProduct(id);
                      } catch(error) {
                        scaffold.showSnackBar(SnackBar(content: Text("Deleting failed!", textAlign: TextAlign.center,),));
                      }
                    },
                    color: Theme.of(context).errorColor),
              ],
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
