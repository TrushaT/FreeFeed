import 'dart:collection';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:FreeFeed/maps/locations.dart' as locations;
import 'package:location/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './chat_screen.dart';

class NGOLocation extends StatefulWidget {
  @override
  _NGOLocationState createState() => _NGOLocationState();
}

class _NGOLocationState extends State<NGOLocation> {
  //Testing
//  @override
//  void initState() {
//    final user = FirebaseAuth.instance.currentUser;
//    FirebaseFirestore.instance.collection('users').doc(user.uid).get().then((value){
//      print(user.email);
//      print(value['role']);

//    });
//    super.initState();
//  }
  final Map<String, Marker> _markers = {}; //declaring markers map
  GoogleMapController controller;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    GeolocationStatus permissionStatus;

    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    var currentLocation = await Geolocator().getCurrentPosition();

    final NGOLocation = await locations.getLocations();

    List<locations.NGOs> finallist = [];

    for (final location in NGOLocation.results) {
      print("inside loop");
      double distance = await Geolocator().distanceBetween(
          currentLocation.latitude,
          currentLocation.longitude,
          location.position[0],
          location.position[1]);

      print(distance);
      if (distance <= 2000) {
        // NGOLocation.results.remove(location);
        finallist.add(location);
      }
    }

    setState(() {
      for (final location in finallist) {
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
        actions: [
          FlatButton(
            child: Text('Logout'),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
          FlatButton(
            child: Text('Chat Screen'),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChatScreen())),
          ),
        ],
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
