import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'), actions: [FlatButton(onPressed: () => FirebaseAuth.instance.signOut(), child: Text('Logout'))],),
      body: Center(child: Text('Home Screen'),),
    );
  }
}
