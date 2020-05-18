import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutterexample/places/screens/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  final Function selectLatLon;

  LocationInput(this.selectLatLon);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    try {
      final locationData = await Location().getLocation();
      setState(() {
        _previewImageUrl = "https://staticmapmaker.com/img/google@2x.png";
      });
      widget.selectLatLon(locationData.latitude, locationData.longitude);
    } catch(error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(isSelecting: true)
        )
    );
    if(selectedLocation != null) {
      setState(() {
        _previewImageUrl = "https://staticmapmaker.com/img/google@2x.png";
      });
      widget.selectLatLon(selectedLocation.latitude, selectedLocation.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? Text(
            "No Location chosen",
            textAlign: TextAlign.center,
          )
              : Image.network(
            _previewImageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text("Current Location"),
              textColor: Theme
                  .of(context)
                  .primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text("Select on Map"),
              textColor: Theme
                  .of(context)
                  .primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
