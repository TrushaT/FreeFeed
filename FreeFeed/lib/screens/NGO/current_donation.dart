import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:FreeFeed/models/currentdonation.dart';
import 'package:FreeFeed/models/NGO.dart';
import 'donation.dart';

class CurrentDonationService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference currentdonationserviceCollection =
      FirebaseFirestore.instance.collection('currentdonations');

  final CollectionReference donationCollection =
      FirebaseFirestore.instance.collection('donations');

  List<Donations> currentdonationlist = [];

  Future<List<Donations>> getcurrentdonations(userId) async {
    List<String> currentlist;
    await currentdonationserviceCollection
        .doc(userId)
        .get()
        .then((value) async {
      print('here');
      print(value.data());
      currentlist = List.from(value.data()['donationid']);
      print(currentlist);
      for (var id in currentlist) {
        print(id);
        await donationCollection.doc(id).get().then((value) async {
          print("here");
          print(value.data());
          Donations donation = Donations(
              decription: value.data()['decription'],
              food_quantity: value.data()['food_quantity']);
          print(donation);
          currentdonationlist.add(donation);
          print(currentdonationlist);
        });
      }
    });
    print('currentdonationlist');
    print(currentdonationlist);
    return currentdonationlist;
  }
}
