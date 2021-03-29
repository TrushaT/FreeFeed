import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonationHistory extends StatefulWidget {
  @override
  _DonationHistoryState createState() => _DonationHistoryState();
}

class _DonationHistoryState extends State<DonationHistory> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference donations =
      FirebaseFirestore.instance.collection('donations');
  User user;
  String ngoId;

  String username = '';

  @override
  void initState() {
    user = auth.currentUser;
    ngoId = user.uid;
    super.initState();
  }

  getusername(user) async {
    DocumentSnapshot ref =
        await FirebaseFirestore.instance.collection('users').doc(user).get();
    setState(() {
      username = ref.data()['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print("INside history");
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('donations')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final List donations = snapshot.data.docs;

                  final donationList = donations
                      .where((donation) => donation['ngoid'] == ngoId)
                      .toList();

                  print(donationList.length);
                  print(donationList);

                  return donationList.length == 0
                      ? Container(
                          child: Text('No Donation Requests'),
                        )
                      : ListView.builder(
                          itemBuilder: (ctx, i) => Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Card(
                                  margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    leading: Container(
                                      padding: EdgeInsets.only(right: 12.0),
                                      decoration: new BoxDecoration(
                                          border: new Border(
                                              right: new BorderSide(
                                                  width: 1.0,
                                                  color: Colors.black))),
                                      child: Icon(Icons.list_alt,
                                          color: Colors.black),
                                    ),
                                    title: Text(
                                      "${donationList[i]['decription']}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Row(
                                      children: <Widget>[
                                        Icon(Icons.calendar_today),
                                        Text(
                                            " ${donationList[i]['date_of_donation'].toDate().toString().split(" ")[0]} ",
                                            style:
                                                TextStyle(color: Colors.black))
                                      ],
                                    ),
                                    trailing:
                                        // Column(children: <Widget>[
                                        Icon(Icons.room_service_outlined,
                                            color: Colors.black, size: 30.0),
                                       
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                content: ListTile(
                                                  title: Text(
                                                      "Request by : User "),
                                                  subtitle: Text(" Quantity: ${donationList[i]['food_quantity']}"),
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text('Ok'),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                  ),
                                                ],
                                              ));

                                      
                                    },

                                    // ]),
                                  ))),
                          itemCount: donationList.length,
                        );
                })));
  }
}
