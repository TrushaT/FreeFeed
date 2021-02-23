import 'package:FreeFeed/models/currentdonation.dart';
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
  List<Donations> currentdonation_list;
  CollectionReference service =
      FirebaseFirestore.instance.collection('Current');
  final FirebaseAuth auth = FirebaseAuth.instance;
  String userId;
  CurrentDonationService _currentDonationService = CurrentDonationService();

  @override
  void initState() {
    final User user = auth.currentUser;
    userId = user.uid;
    getCurrentDonations(user.uid);
    super.initState();
  }

  Future getCurrentDonations(uid) async {
    currentdonation_list =
        await _currentDonationService.getcurrentdonations(uid);
    print('here');
    print(currentdonation_list);
    setState(() {
      currentdonation_list = currentdonation_list;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Container(
    //   child: Center(
    //     child: Text('Donation Requests '),
    //   ),
    //   padding: EdgeInsets.all(5),
    // );
    // print(currentdonation_list);
    // return StreamBuilder(
    //   stream: FirebaseFirestore.instance
    //       .collection('currentdonation')
    //       .where('uid', isEqualTo: userId)
    //       .snapshots(),
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (!snapshot.hasData) {
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
      return Scaffold(
          appBar: AppBar(
            title: Text('Welcome to FreeFeed !'),
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
                    Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => AuthScreen()));
                  }
                ),
              ],
          ),
      
        body: currentdonation_list == null
            ? Container(child: Loading())
            : ListView.builder(
                itemCount: currentdonation_list.length,
                itemBuilder: (context, index) {
                  print(currentdonation_list[index].decription);
                  return Container(
                    child: DonationTile(currentdonation_list[index]),
                  );
                })
      );
    //   },
    // );
  }
}
