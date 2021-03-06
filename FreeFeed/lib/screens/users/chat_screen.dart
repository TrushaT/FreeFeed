import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:FreeFeed/widgets/messages.dart';
import 'package:FreeFeed/widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String ngoId;

  ChatScreen(this.userId, this.ngoId);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      backgroundColor: Colors.blue,
       ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(widget.userId, widget.ngoId),
            ),
            NewMessage(widget.userId, widget.ngoId),
          ],
        ),
        
      ),
    );
  }
}
