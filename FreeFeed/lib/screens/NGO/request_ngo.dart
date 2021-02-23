import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:FreeFeed/models/NGO.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'donationrequestlist.dart';

class notifyNGOService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  List<NGO_User> nearby_ngo_list = [];

  List<NGO_User> _userFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      if (doc.data()['role'] == "ngo") {
        return NGO_User(
            uid: doc.id,
            username: doc.data()['username'],
            latitude: doc.data()['latitude'],
            longitude: doc.data()['longitude'],
            role: doc.data()['role'],
            email: doc.data()['email'],
            donationlistid: doc.data()['donationlistid']);
      }
    }).toList();
  }

  Stream<List<NGO_User>> get ngo {
    return userCollection.snapshots().map(_userFromSnapshot);
  }

  Future<List<NGO_User>> getNGOs(donationid) async {
    var currentlocation = await Geolocator().getCurrentPosition();

    await userCollection
        .where('role', isEqualTo: 'ngo')
        .get()
        .then((value) => value.docs.forEach((element) async {
          print(element);
              print(currentlocation.latitude);
              print(currentlocation.longitude);
              print(element.data()['latitude']);
              print(element.data()['longitude']);

              double distance = await Geolocator().distanceBetween(
                currentlocation.latitude,
                currentlocation.longitude,
                double.parse(element.data()['latitude']),
                double.parse(element.data()['longitude']),
              );

              print('distance');
              print(distance);

              if (distance <= 2000) {
                print('if within distance');
                NGO_User user = NGO_User(
                    uid: element.reference.id ,
                    username: element.data()['username'],
                    latitude: element.data()['latitude'],
                    longitude: element.data()['longitude'],
                    role: element.data()['role'],
                    email: element.data()['email'],
                    donationlistid: element.data()['donationlistid']);
                nearby_ngo_list.add(user);
                print(user.uid);
                CurrentDonationList(user, donationid);
              }
            }));
  
    return (nearby_ngo_list);
  }
}
