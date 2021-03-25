import 'package:FreeFeed/models/NGO.dart';
import 'package:FreeFeed/models/users.dart';
import 'package:FreeFeed/widgets/conversationList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatwithNgo extends StatefulWidget {
  final String role;

  ChatwithNgo(this.role);

  @override
  _ChatwithNgo createState() => _ChatwithNgo();
}

class _ChatwithNgo extends State<ChatwithNgo> {
  Map<String, String> userData = {};
  List<String> ngos = [];
  List<String> users = [];
  var user;
  var _isLoading = true;

  @override
  void didChangeDependencies() {
    user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var i in value.docs) {
        userData[i.id] = i.data()['username'];
        if (i.data()['role'] == 'ngo') {
          ngos.add(i.id);
        } else {
          users.add(i.id);
        }
      }
      print("One");
      if (widget.role == 'user') {
        print(ngos);
        for (var i in ngos) {
          FirebaseFirestore.instance
              .collection('$i-${user.uid}')
              .orderBy('createdAt', descending: true)
              .get()
              .then((value) {
            print("inside");
            if (value.docs.length > 0) {
              print("thereeee");
              ngoUsers.add(
                NGO_User(
                    uid: i,
                    username: userData[i],
                    messageText: value.docs[0].data()['text'],
                    imageURL: "assets/ngo1.jpg",
                    time: value.docs[0].data()['createdAt'].toDate().toString().substring(0, 11)),
              );
            }
            setState(() {});
          });
        }
      } else {
        print("Two");
        print(users);
        for (var i in users) {
          FirebaseFirestore.instance
              .collection('${user.uid}-$i')
              .orderBy('createdAt', descending: true)
              .get()
              .then((value) {
            print("inside");
            print(value.docs.length);
            if (value.docs.length > 0) {
              print("hereeee");
              ngoUsers.add(
                NGO_User(
                    uid: i,
                    username: userData[i],
                    messageText: value.docs[0].data()['text'],
                    imageURL: "assets/ngo1.jpg",
                    time: value.docs[0].data()['createdAt'].toDate().toString().substring(0, 11)),
              );
            }
            setState(() {});
          });
        }
      }
      setState(() {
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  List<NGO_User> ngoUsers = [
//    NGO_User(
//        username: "NGO1",
//        messageText: "Thank you for the donation",
//        imageURL: "assets/ngo1.jpg",
//        time: "23 March"),
//    NGO_User(username: "NGO2", messageText: "Thank you for the donation", imageURL:"assets/ngo1.jpg",time:"18 March" ),
//    NGO_User(username: "NGO3", messageText: "Thank you for the donation", imageURL:"assets/ngo1.jpg",time:"22 March" ),
//    NGO_User(username: "NGO4", messageText: "Thank you for the donation", imageURL:"assets/ngo1.jpg",time:"23 March" ),
//    NGO_User(username: "NGO4", messageText: "Thank you for the donation", imageURL:"assets/ngo1.jpg",time:"23 March" ),
//    NGO_User(username: "NGO4", messageText: "Thank you for the donation", imageURL:"assets/ngo1.jpg",time:"23 March" ),
//    NGO_User(username: "NGO4", messageText: "Thank you for the donation", imageURL:"assets/ngo1.jpg",time:"23 March" ),
//    NGO_User(username: "NGO4", messageText: "Thank you for the donation", imageURL:"assets/ngo1.jpg",time:"23 March" ),

    /* NGO_User(text: "Debra Hawkins", secondaryText: "Thankyou, It's awesome", image: "images/userImage5.jpeg", time: "23 Mar"),
    NGO_User(text: "Jacob Pena", secondaryText: "will update you in evening", image: "images/userImage6.jpeg", time: "17 Mar"),
    NGO_User(text: "Andrey Jones", secondaryText: "Can you please share the file?", image: "images/userImage7.jpeg", time: "24 Feb"),
    NGO_User(text: "John Wick", secondaryText: "How are you?", image: "images/userImage8.jpeg", time: "18 Feb"), */
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
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
            ), */
//      body: FutureBuilder(
//          future: FirebaseFirestore.instance.collection('f').get(),
//          builder: (context, snapshot) {
//            if (snapshot.connectionState == ConnectionState.waiting) {
//              return Center(
//                child: CircularProgressIndicator(),
//              );
//            } else if (userData.length == 0) {
//              return Text('No chats');
//            }
//            print("NOW");
//            //print(snapshot.data.docs);
//            if (widget.role == 'ngo') {
//              for (var i in snapshot.data) {
//                ngoUsers.add(NGO_User(
//                    username: userData[i.id],
//                    messageText: "Thank you for the donation",
//                    imageURL: "assets/ngo1.jpg",
//                    time: "23 March"));
//              }
//            } else {
//              print("Inside else");
//              print(snapshot.data);
//              print(snapshot.data.docs.length);
//            if(snapshot.data.docs.length > 0) {
//                ngoUsers.add(NGO_User(
//                    username: userData[i.id],
//                    messageText: "Thank you for the donation",
//                    imageURL: "assets/ngo1.jpg",
//                    time: "23 March"));
//              }
//              for (var i in snapshot.data.docs) {
//                print("In user loop");
//                print(i);
//              }
      //}
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /*Padding(
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
),*/
                      ListView.builder(
                        itemCount: ngoUsers.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 16),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ConversationList(
                                userId: widget.role == 'ngo'
                                    ? ngoUsers[index].uid
                                    : user.uid,
                                ngoId: widget.role == 'user'
                                    ? ngoUsers[index].uid
                                    : user.uid,
                                name: ngoUsers[index].username,
                                messageText: ngoUsers[index].messageText,
                                imageUrl: ngoUsers[index].imageURL,
                                time: ngoUsers[index].time,
                                //isMessageRead: (index == 0 || index == 3)?true:false,
                              ),
                              Divider(),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
    );
  }
}
