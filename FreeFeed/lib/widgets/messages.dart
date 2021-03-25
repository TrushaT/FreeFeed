import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  final String userId;
  final String ngoId;

  Messages(this.userId, this.ngoId);

  @override
  Widget build(BuildContext context) {
        final user = FirebaseAuth.instance.currentUser;
        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('$ngoId-$userId')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocs = chatSnapshot.data.docs;
              print(chatDocs);
              return ListView.builder(
                reverse: true,
                itemBuilder: (ctx, i) => MessageBubble(
                    chatDocs[i]['text'],
                    chatDocs[i]['userId'] == user.uid,
                    chatDocs[i]['username'],
                    key: ValueKey(chatDocs[i].id)),
                itemCount: chatDocs.length,
              );
            });
      }
  }
