import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:FreeFeed/maps/locations.dart' as locations;

class NGOLocation extends StatefulWidget {
  @override
  _NGOLocationState createState() => _NGOLocationState();
}

class _NGOLocationState extends State<NGOLocation> {
  final Map<String, Marker> _markers = {}; //declaring markers map
  GoogleMapController controller;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    // void _setMapStyle() async {
    //   String style = await DefaultAssetBundle.of(context)
    //       .loadString('assets/mapstyle.json');
    //   controller.setMapStyle(style);
    // }

    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print(currentLocation);
    // _setMapStyle();
    final NGOLocation = await locations.getLocations();
    setState(() {
      // _markers.clear();
      for (final location in NGOLocation.results) {
        
        final marker = Marker(
          markerId: MarkerId(location.title),
          position: LatLng(location.position[0], location.position[1]),
          infoWindow: InfoWindow(
            title: location.title,
          ),
          icon: BitmapDescriptor.defaultMarker,
        );
        _markers[location.title] = marker;
      }

      final marker1 = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );
      print(currentLocation.latitude + currentLocation.longitude);
      _markers["curr_loc"] = marker1;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target:
                  LatLng(currentLocation.latitude, currentLocation.longitude),
              zoom: 16.0),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(20.5937, 78.9629),
          zoom: 6,
        ),
        onMapCreated: _onMapCreated,
        markers: _markers.values.toSet(),
        myLocationEnabled: true,
      ),
    ));
  }
}
