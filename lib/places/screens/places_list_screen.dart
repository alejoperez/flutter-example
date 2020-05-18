import 'package:flutter/material.dart';
import 'package:flutterexample/places/screens/add_place_screen.dart';
import 'package:flutterexample/places/screens/palces_detail_screen.dart';
import 'package:flutterexample/providers/places_provider.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your places"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.ROUTE_NAME);
              })
        ],
      ),
//      body: Center(child: CircularProgressIndicator()),
      body: FutureBuilder(
        future:
            Provider.of<PlacesProvider>(context, listen: false).fetchPlaces(),
        builder: (ctx, dataSnapshot) => dataSnapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<PlacesProvider>(
                child: Center(
                  child: Text(
                    "No Places yet!\n:(",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                builder: (ctx, placesProvider, noPlacesView) => placesProvider
                        .places.isEmpty
                    ? noPlacesView
                    : ListView.builder(
                        itemCount: placesProvider.places.length,
                        itemBuilder: (ctx, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                    placesProvider.places[index].image),
                              ),
                              title: Text(placesProvider.places[index].title),
                              subtitle: Text(placesProvider.places[index].location.address),
                              onTap: () {
                                Navigator.of(context).pushNamed(PlaceDetailScreen.ROUTE_NAME, arguments: placesProvider.places[index].id);
                              },
                            )),
              ),
      ),
    );
  }
}
