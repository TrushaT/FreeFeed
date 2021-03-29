import 'package:FreeFeed/screens/users/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NgoDetails extends StatefulWidget {
  String userId;
  String ngoId;
  NgoDetails(this.userId, this.ngoId);
  @override
  NgoDetailsState createState() => NgoDetailsState();
}

class NgoDetailsState extends State<NgoDetails> {
  String ngousername;

  getngoname(ngo) async {
    DocumentSnapshot ref =
        await FirebaseFirestore.instance.collection('users').doc(ngo).get();
        setState(() {
           ngousername = ref.data()['username'];
        });
   

  }

  @override
  void initState() {
    getngoname(widget.ngoId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('NGO details'),
        ),
        body: new ListView(children: <Widget>[
          new Image.asset(
            'assets/ngo1.jpg',
            height: 300,
            fit: BoxFit.fitHeight,
          ),
          new Container(
            padding: const EdgeInsets.all(32.0),
            child: new Row(
              children: [
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Code to create the view for name.
                      new Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: new Text(
                          "$ngousername",
                          style: new TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      new Row(
                        children: [
                          new Icon(
                            Icons.phone,
                            color: Colors.green,
                            size: 26,
                          ),
                          new Text(
                            '+919876543210',
                            style: new TextStyle(
                              fontSize: 20,
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                // Icon to indicate chat.
                new FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            ChatScreen(widget.userId, widget.ngoId)));
                  },
                  child: const Icon(Icons.message_rounded),
                  backgroundColor: Colors.green,
                ),
              ],
            ),
          ),
          new Expanded(
              child: new Container(
                  padding: const EdgeInsets.all(32.0),
                  child: new Row(children: [
                    new Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 26,
                    ),
                    new Text(
                      'T.P.S Road, Borivali(West),Mumbai.',
                      //overflow: TextOverflow.ellipsis,
                      style: new TextStyle(
                        fontSize: 20,
                        //fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      softWrap: true,
                    )
                  ])))
        ]));
  }
}
