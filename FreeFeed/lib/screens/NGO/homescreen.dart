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
  List<Donations> currentDonationList =  [
     Donations(decription: 'Wedding at Borivali',food_quantity: '5 kgs'),
     Donations(decription: 'Reception at Kandivali',food_quantity: '2 kgs'),
     Donations(decription: 'Family function',food_quantity: '4 kgs') ,
     Donations(decription: 'Family function',food_quantity: '4 kgs'),
     Donations(decription: 'Family function',food_quantity: '4 kgs'),
     Donations(decription: 'Family function',food_quantity: '4 kgs'),
     Donations(decription: 'Family function',food_quantity: '4 kgs') 
  ];

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
    currentDonationList =
        await _currentDonationService.getcurrentdonations(uid);
    print('here');
    print(currentDonationList);
    setState(() {
      currentDonationList = currentDonationList;
    });
  }

   // ignore: non_constant_identifier_names
   Widget currentDonationsCard(Donations) {
     return Padding(
       padding: const EdgeInsets.all(8.0),
      
       child: Card(
         color: Colors.blue.shade200,
         child: Row(
             children: <Widget>[
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Text('food Donation request',
                     style: TextStyle (
                         color: Colors.black,
                         fontSize: 18
                     ),
                   ),
                   Text('2 kgs',
                     style: TextStyle (
                         color: Colors.black,
                         fontSize: 12
                     ),
                   )
                 ],
                 
               ),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                   ButtonBar(
                    alignment: MainAxisAlignment.end,
                    children: [
                      /* FlatButton(
                        onPressed: () {
                          // Perform some action
                        },
                        child: const Text('Details'),
                         ),*/
                      FlatButton(
                        onPressed: () {
                          // Perform some action
                        },
                        //child: const Text(''),
                        child: Icon(
                    Icons.check_circle,
                    color: Colors.green[600],
                  ),
                      ),
                      FlatButton(
                        onPressed: () {
                          // Perform some action
                        },
                        child: Icon(
                    Icons.cancel_rounded,
                    color: Colors.red[400],
                  ),
                      ),
                    ],
                  ),
                 ],
               )
               
             ],
           ),
         ),
      // ),
     );
   }

  @override
  Widget build(BuildContext context) {
    print("INside build NGO home screen");
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
                  }
                ),
              ],
          ),
          body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
        child: Column(
          children: <Widget>[
            Column(
              children: currentDonationList.map((d) {
                return currentDonationsCard(d);
              }).toList()
            )
          ],
        ),
      ),
      drawer: DrawerScreen(),
      
        /* body: currentDonationList == null
            ? Container(child: Loading())
            : ListView.builder(
                itemCount: currentDonationList.length,
                itemBuilder: (context, index) {
                  print(currentDonationList[index].decription);
                  return Container(
                    child: DonationTile(currentDonationList[index]),
                  );
                }) */
      );
    //   },
    // );
  }
}
