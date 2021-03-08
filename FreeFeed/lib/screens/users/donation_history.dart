import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationHistory extends StatefulWidget {
  @override
  _DonationHistoryState createState() => _DonationHistoryState();
}

class _DonationHistoryState extends State<DonationHistory> {
  var _isLoading = true;
  List donationList = [];

  @override
  void initState() {
    final userId = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection('donations').
        where('userid', isEqualTo: userId).
    get().then((donations) {
      donations.docs.forEach((donation) {
        donationList.add(donation.data()['decription']);
      });
      setState(() {
        if (!mounted) return;
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(donationList);
    return Scaffold(
        appBar: AppBar(
          title: Text('Donation History'),
        ),
        body: _isLoading ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(itemBuilder: (ctx, i) => Text(donationList[i]),
          itemCount: donationList.length,));
  }
}
