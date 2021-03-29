import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String token_value = '';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    // getToken();

    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            alert: true, badge: true, provisional: true, sound: true));

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        //_showItemDialog(message);
      },
      //onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        //_navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        //_navigateToItemDetail(message);
      },
    );

    firebaseMessaging.getToken().then((token) {
      update(token);
    });

    super.initState();
  }

  update(String token) async {
    print(token);
    DocumentReference ref = await FirebaseFirestore.instance.collection('donations').doc();
    ref.set({'token': token});
    token_value = token;
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Token : $token_value")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(token_value);
        },
        child: Icon(Icons.print),
      ),
    );
  }
}
