import 'package:flutter/material.dart';
import 'package:flutterexample/places/screens/map_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutterexample/providers/places_provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const ROUTE_NAME = "/place-detail";
  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute
        .of(context)
        .settings
        .arguments;
    final place = Provider.of<PlacesProvider>(context, listen: false).findById(placeId);
    return Scaffold(
      appBar: AppBar(title: Text(place.title),),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            child: Image.file(
              place.image, fit: BoxFit.cover, width: double.infinity,),
          ),
          SizedBox(height: 10,),
          Text(place.location.address, textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),),
          SizedBox(height: 10,),
          FlatButton(child: Text("View on Map",), textColor: Theme
              .of(context)
              .primaryColor,
            onPressed:() {
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (ctx) => MapScreen(initialLocation: place.location,isSelecting: false,)
              )
            );
            },
          )
        ],
      ),
    );
  }
}
