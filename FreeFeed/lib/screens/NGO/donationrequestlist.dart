import 'package:flutter/material.dart';
import 'request_ngo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:FreeFeed/models/NGO.dart';
import 'package:FreeFeed/models/currentdonation.dart';
import 'package:FreeFeed/models/donation.dart';

class CurrentDonationList {
  CurrentDonationList(NGO_User nearby_ngo, String donationid) {
    print('here in CDL ');

      print(nearby_ngo.uid);
      print(donationid);
      FirebaseFirestore.instance
          .collection('currentdonations')
          .doc(nearby_ngo.uid)
          .update({
        'donationid': FieldValue.arrayUnion([donationid])
       });
    
  }
}
