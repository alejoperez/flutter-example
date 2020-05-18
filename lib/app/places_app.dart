import 'package:flutter/material.dart';
import 'package:flutterexample/places/screens/add_place_screen.dart';
import 'package:flutterexample/places/screens/palces_detail_screen.dart';
import 'package:flutterexample/places/screens/places_list_screen.dart';
import 'package:flutterexample/providers/places_provider.dart';
import 'package:provider/provider.dart';

class PlacesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlacesProvider(),
      child: MaterialApp(
        title: "Great Places",
        theme: ThemeData(
            primarySwatch: Colors.lightBlue, accentColor: Colors.deepOrangeAccent),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.ROUTE_NAME: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.ROUTE_NAME: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
