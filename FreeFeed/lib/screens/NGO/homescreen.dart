import 'package:FreeFeed/models/currentdonation.dart';
import 'package:FreeFeed/screens/NGO/donationrequestlist.dart';
import 'package:FreeFeed/screens/NGO/drawerscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'current_donation.dart';
import 'package:FreeFeed/widgets/loading.dart';
import 'donation_tile.dart';
import 'donation.dart';
import '../users/chat_screen.dart';
import '../authenticate/auth_screen.dart';

class NGOHomeScreen extends StatefulWidget {
  @override
  _NGOHomeScreenState createState() => _NGOHomeScreenState();
}

class _NGOHomeScreenState extends State<NGOHomeScreen> {
  CollectionReference service =
      FirebaseFirestore.instance.collection('Current');
  final FirebaseAuth auth = FirebaseAuth.instance;
  String userId;
  CurrentDonationService _currentDonationService = CurrentDonationService();
  User user;

  @override
  void initState() {
    user = auth.currentUser;
    userId = user.uid;
    super.initState();
  }

  // Widget currentDonationsCard(Donations) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),

  //     child: Card(
  //       color: Colors.white,
  //       child: Row(
  //         children: <Widget>[
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               Text(
  //                 'food Donation request',
  //                 style: TextStyle(color: Colors.black, fontSize: 18),
  //               ),
  //               Text(
  //                 '2 kgs',
  //                 style: TextStyle(color: Colors.black, fontSize: 12),
  //               )
  //             ],
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             children: [
  //               ButtonBar(
  //                 alignment: MainAxisAlignment.end,
  //                 children: [
  //                   /* FlatButton(
  //                       onPressed: () {
  //                         // Perform some action
  //                       },
  //                       child: const Text('Details'),
  //                        ),*/
  //                   FlatButton(
  //                     onPressed: () {
  //                       // Perform some action
  //                     },
  //                     //child: const Text(''),
  //                     child: Icon(
  //                       Icons.check_circle,
  //                       color: Colors.green[600],
  //                     ),
  //                   ),
  //                   FlatButton(
  //                     onPressed: () {
  //                       // Perform some action
  //                     },
  //                     child: Icon(
  //                       Icons.cancel_rounded,
  //                       color: Colors.red[400],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //     // ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    print("INside build NGO home screen");

    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Requests'),
        actions: [
          FlatButton(
            child: Text('Chat'),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => ChatScreen())),
          ),
          FlatButton(
              child: Text('Logout'),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('currentdonations')
                .doc(userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final doc = snapshot.data.data()['donationid'];
              print(doc);

              //print(docs.runtimeType);
              //var donations = getDonations(docs);

              return FutureBuilder(
                  future:
                      FirebaseFirestore.instance.collection('donations').get(),
                  builder: (ctx, dSnapshot) {
                    if (dSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final List donations = dSnapshot.data.docs;
                    //print(donations[0].id);
                    //return FlutterLogo();
                    print(doc);
                    print(donations);
                    final finalDonations = donations
                        .where((donation) => doc.contains(donation.id))
                        .toList();

                    print('no of donations');
                    print(finalDonations.length);
                    return finalDonations == null
                        ? Container(
                            child: Text('No Donation Requests'),
                          )
                        : ListView.builder(
                            itemBuilder: (ctx, i) => DonationTile(Donations(
                                decription: finalDonations[i]['decription'],
                                food_quantity: finalDonations[i]
                                    ['food_quantity'])),
                            itemCount: finalDonations.length,
                          );
                  });
            }),
      ),
      drawer: DrawerScreen(),
    );
  }
}
