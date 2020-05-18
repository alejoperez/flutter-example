import 'package:flutter/material.dart';
import 'package:flutterexample/domain/place.dart';
import 'package:flutterexample/places/widgets/image_input.dart';
import 'package:flutterexample/places/widgets/location_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutterexample/providers/places_provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const ROUTE_NAME = "/add-place";

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectPlace(double lat, double lon) {
    _pickedLocation = PlaceLocation(
      latitude: lat,
      longitude: lon
    );
  }

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savedPlace() {
    if(_titleController.text.isNotEmpty && _pickedImage != null && _pickedLocation != null) {
      Provider.of<PlacesProvider>(context, listen: false).addPlace(_titleController.text, _pickedImage, _pickedLocation);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new place"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: "Title"),
                    ),
                    SizedBox(height: 10),
                    ImageInput(_selectImage),
                    SizedBox(height: 10),
                    LocationInput(_selectPlace)
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.add),
            label: Text("Add Place"),
            onPressed: _savedPlace,
          )
        ],
      ),
    );
  }
}
