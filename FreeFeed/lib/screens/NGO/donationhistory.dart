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
    final ngoID = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection('donations').
        where('ngoid', isEqualTo: ngoID).
    get().then((donations) {
      donations.docs.forEach((donation) {
        donationList.add(donation);
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
        // appBar: AppBar(
        //   title: Text('Donation History'),
        // ),
        body: _isLoading ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(itemBuilder: (ctx, i) => Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right:
                              new BorderSide(width: 1.0, color: Colors.black))),
                  child: Icon(Icons.list_alt, color: Colors.black),
                ),
                title: Text(
                  // "Introduction to Driving",
                  "${donationList[i]['decription']}",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.calendar_today),
                    Text(" ${donationList[i]['date_of_donation'].toDate().toString().split(" ")[0]} ",
                        style: TextStyle(color: Colors.black))
                  ],
                ),
                trailing: 
                Column(
                  children:<Widget>[Icon(Icons.room_service_outlined,
                    color: Colors.black, size: 30.0),
                    Text(" ${donationList[i]['food_quantity']} ",
                        style: TextStyle(color: Colors.black))
                    ]),
                  
                    ))),
          itemCount: donationList.length,));
            
  }
}
