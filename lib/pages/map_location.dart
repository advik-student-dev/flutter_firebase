import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _pNorthEasternSeattle =
      LatLng(47.62072920437455, -122.33745229057433);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Set background color to black
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back when button is pressed
          },
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _pNorthEasternSeattle,
          zoom: 13,
        ),
      ),
    );
  }
}
