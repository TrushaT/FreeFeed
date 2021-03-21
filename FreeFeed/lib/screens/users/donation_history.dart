import 'package:FreeFeed/screens/users/drawerscreen.dart';
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
  final ScrollController _scrollController = ScrollController();

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
              title: const Text('Donation History'),
              backgroundColor: Colors.cyan[300],
              actions: [
                FlatButton(
                  child: Text('Logout'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  }
                ),
              ],
            ),
             body: Center(
          child: Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController,
            child: ListView.builder(
                controller: _scrollController,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    title: Text("Donation 1"),
                  ));
                }),
          ),
        ),
       
        drawer: UserDrawerScreen(), 
        );
        
  }
}
