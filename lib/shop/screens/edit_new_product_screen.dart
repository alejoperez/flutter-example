import 'package:flutter/material.dart';
import 'package:flutterexample/providers/product_provider.dart';
import 'package:flutterexample/providers/product_list_provider.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const ROUTE_NAME = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: "", title: "", price: 0, description: "", imageUrl: "");
  var _isInitProductLoaded = false;
  var _isLoading = false;
  var _initValues = {
    "title": "",
    "description": "",
    "price": "",
    "imageUrl": "",
  };

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitProductLoaded) {
      final String productId = ModalRoute.of(context).settings.arguments;
      if (productId != null) {
        _editedProduct =
            Provider.of<ProductListProvider>(context, listen: false)
                .findById(productId);
        _initValues = {
          "title": _editedProduct.title,
          "description": _editedProduct.description,
          "price": _editedProduct.price.toString()
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
      _isInitProductLoaded = false;
    }
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty) {
        return;
      }
      if (!_imageUrlController.text.startsWith("http")) {
        return;
      }
      if (!_imageUrlController.text.endsWith(".jpg") &&
          !_imageUrlController.text.endsWith(".jpeg") &&
          !_imageUrlController.text.endsWith(".png")) {
        return;
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();

    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();

    _imageUrlController.dispose();
  }

  void _saveForm() async {
    if (_form.currentState.validate()) {
      _form.currentState.save();

      setState(() { _isLoading = true; });

      if (_editedProduct.id.isEmpty) {
        try {
          await Provider.of<ProductListProvider>(context, listen: false).addProduct(_editedProduct);
        } catch (error) {
          await showDialog<Null>(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text("Error"),
                    content: Text(error.toString()),
                    actions: [
                      FlatButton(
                        child: Text("Ok"),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                      )
                    ],
                  ));
        }
      } else {
        await Provider.of<ProductListProvider>(context, listen: false).updateProduct(_editedProduct);
      }

      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _initValues["title"],
                        decoration: InputDecoration(labelText: "Title"),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(_priceFocusNode),
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              title: value,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: _editedProduct.imageUrl,
                              isFavorite: _editedProduct.isFavorite);
                        },
                        validator: (value) =>
                            value.isEmpty ? "Please provide a title" : null,
                      ),
                      TextFormField(
                          initialValue: _initValues["price"],
                          decoration: InputDecoration(labelText: "Price"),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          focusNode: _priceFocusNode,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode),
                          onSaved: (value) {
                            _editedProduct = Product(
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                price: double.tryParse(value),
                                imageUrl: _editedProduct.imageUrl,
                                isFavorite: _editedProduct.isFavorite);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please provide a price";
                            }
                            if (double.tryParse(value) == null) {
                              return "Please provide a valid price";
                            }
                            if (double.parse(value) <= 0) {
                              return "Please provide a price greater than zero";
                            }
                            return null;
                          }),
                      TextFormField(
                        initialValue: _initValues["description"],
                        decoration: InputDecoration(labelText: "Description"),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: value,
                              price: _editedProduct.price,
                              imageUrl: _editedProduct.imageUrl,
                              isFavorite: _editedProduct.isFavorite);
                        },
                        validator: (value) => value.isEmpty
                            ? "Please provide a description"
                            : null,
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: _imageUrlController.text.isEmpty
                                ? Center(
                                    child: Text(
                                    "Enter a URL",
                                    textAlign: TextAlign.center,
                                  ))
                                : FittedBox(
                                    child: Image.network(
                                        _imageUrlController.text,
                                        fit: BoxFit.cover)),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: "Image URL"),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                controller: _imageUrlController,
                                focusNode: _imageUrlFocusNode,
                                onFieldSubmitted: (_) {
                                  _saveForm();
                                },
                                onSaved: (value) {
                                  _editedProduct = Product(
                                      id: _editedProduct.id,
                                      title: _editedProduct.title,
                                      description: _editedProduct.description,
                                      price: _editedProduct.price,
                                      imageUrl: value,
                                      isFavorite: _editedProduct.isFavorite);
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please provide a non-empty URL";
                                  }
                                  if (!value.startsWith("http")) {
                                    return "Please provide a valid URL";
                                  }
                                  if (!value.endsWith(".jpg") &&
                                      !value.endsWith(".jpeg") &&
                                      !value.endsWith(".png")) {
                                    return "Please provide a valid URL";
                                  }
                                  return null;
                                }),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
