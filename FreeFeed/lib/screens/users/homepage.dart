import 'package:flutter/material.dart';
import 'ngo_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'get_nearbyngo.dart';
import 'package:FreeFeed/models/NGO.dart';
import 'package:FreeFeed/widgets/loading.dart';
import 'ngo_details.dart';


class HomePage extends StatefulWidget {
  // final nearbyngos;
  // HomePage(this.nearbyngos);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NGO_User> nearby_ngolist;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String userid = '';


  @override
  void initState() {
    getnearbyNGOs();
    getcurrentuser();
    super.initState();
  }

  getnearbyNGOs() async {
    nearby_ngolist = await getnearbyNGOService().getNGOs();
    setState(() {
      nearby_ngolist = nearby_ngolist;
    });
  }

  getcurrentuser() async {
     final User user = auth.currentUser;
     setState(() {
       userid = user.uid;
     });
  }

  @override
  Widget build(BuildContext context) {
    Container(
      child: Center(
        child: Text('Nearby NGOs'),
      ),
      padding: EdgeInsets.all(5),
    );
    // print(widget.nearbyngos);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: 'ngo')
            .snapshots(),
        builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> dSnapshot) {
          if (!dSnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          print(nearby_ngolist);

          return nearby_ngolist == null
              ? Container(child: Loading())
              : GridView.builder(
                  itemCount: nearby_ngolist.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 8.0 / 10.0,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: EdgeInsets.all(5),
                        child: Card(
                            semanticContainer: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              splashColor: Colors.cyan[100],
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => NgoDetails(userid,nearby_ngolist[index].uid)));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "${nearby_ngolist[index].username}",
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  Text(
                                    "NGO details",
                                    style: TextStyle(fontSize: 12.0),
                                  )
                                ],
                              ),
                            )));
                  },
                );
        });
  }
}
