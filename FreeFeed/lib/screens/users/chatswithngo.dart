import 'package:FreeFeed/models/NGO.dart';
import 'package:FreeFeed/models/users.dart';
import 'package:FreeFeed/widgets/conversationList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ChatwithNgo extends StatefulWidget {
  @override
  _ChatwithNgo createState() => _ChatwithNgo();
}

class _ChatwithNgo extends State<ChatwithNgo> {

  List<NGO_User> ngoUsers = [
    NGO_User(username: "NGO1"),
    NGO_User(username: "NGO1"),
    NGO_User(username: "NGO1"),
    NGO_User(username: "NGO1"),
    /* NGO_User(text: "Debra Hawkins", secondaryText: "Thankyou, It's awesome", image: "images/userImage5.jpeg", time: "23 Mar"),
    NGO_User(text: "Jacob Pena", secondaryText: "will update you in evening", image: "images/userImage6.jpeg", time: "17 Mar"),
    NGO_User(text: "Andrey Jones", secondaryText: "Can you please share the file?", image: "images/userImage7.jpeg", time: "24 Feb"),
    NGO_User(text: "John Wick", secondaryText: "How are you?", image: "images/userImage8.jpeg", time: "18 Feb"), */
  ];

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              title: const Text('Chats with NGO'),
              backgroundColor: Colors.cyan[300],
              actions: [
                FlatButton(
                  child: Text('Logout'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  }
                ),
              ],
            ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[


            Padding(
  padding: EdgeInsets.only(top: 16,left: 16,right: 16),
  child: TextField(
    decoration: InputDecoration(
      hintText: "Search...",
      hintStyle: TextStyle(color: Colors.grey.shade600),
      prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: EdgeInsets.all(8),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
              color: Colors.grey.shade100
          )
      ),
    ),
  ),
),
            ListView.builder(
  itemCount: ngoUsers.length,
  shrinkWrap: true,
  padding: EdgeInsets.only(top: 16),
  physics: NeverScrollableScrollPhysics(),
  itemBuilder: (context, index){
    return ConversationList(
      name: ngoUsers[index].username,
      //messageText: ngoUsers[index].messageText,
      //imageUrl: ngoUsers[index].imageURL,
      //time: ngoUsers[index].time,
      //isMessageRead: (index == 0 || index == 3)?true:false,
    );
  },
),
          ],
        ),
      ),
    );

    
  }
}