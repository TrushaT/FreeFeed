import 'package:flutter/material.dart';
import 'package:FreeFeed/screens/users/chatswithngo.dart';

class DrawerScreen extends StatelessWidget {
  final String role;
  DrawerScreen(this.role);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Chats with Donors'),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChatwithNgo(role)))
              ,
            ),
            ListTile(
              title: Text('Pending Donation Requests'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Donation History'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
    );
  }
}


