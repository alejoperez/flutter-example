import 'package:flutter/foundation.dart';
import 'package:flutterexample/database/DatabaseHelper.dart';
import 'package:flutterexample/domain/place.dart';
import 'dart:io';

class PlacesProvider with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places => [..._places];

  Place findById(String id) {
    return _places.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(String title, File pickedImage, PlaceLocation pickedLocation) async {
    final updatedLocation = PlaceLocation(latitude: pickedLocation.longitude, longitude: pickedLocation.longitude, address: "address");
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        image: pickedImage,
        location: updatedLocation);
    _places.add(newPlace);
    notifyListeners();
    DataBaseHelper.insert(DataBaseHelper.PLACES_TABLE, {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
      "lat": newPlace.location.latitude,
      "lon": newPlace.location.longitude,
      "address": newPlace.location.address,

    });
  }

  Future<void> fetchPlaces() async {
    final dataList = await DataBaseHelper.getData(DataBaseHelper.PLACES_TABLE);
    _places = dataList
        .map((data) => Place(
            id: data["id"],
            title: data["title"],
            image: File(data["image"]),
            location: PlaceLocation(
              latitude: data["lat"],
              longitude: data["lon"],
              address: data["address"],
            )))
        .toList();
    notifyListeners();
  }
}
