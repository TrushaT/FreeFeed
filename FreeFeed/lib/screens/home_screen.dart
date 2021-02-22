import 'package:FreeFeed/screens/auth_screen.dart';
import 'package:FreeFeed/screens/ngo.dart';
import 'package:FreeFeed/widgets/favourite_ngos.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('FreeFeed'),
              backgroundColor: Colors.cyan[300],
              actions: [
                FlatButton(
                  child: Text('Locate NGO'),
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => NGOLocation())),
                ),
                FlatButton(
                  child: Text('Chat'),
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => ChatScreen())),
                ),
                FlatButton(
                  child: Text('Logout'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => AuthScreen()));
                  }
                ),
              ],
            ),
            body: Column(
        children: <Widget>[
          
          Expanded(
            child: Column(
              children: <Widget>[
            Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                   Text(
                  'Favorite NGOs',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  'Fav ngos will come here',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                
                  
                ],
                

              ),
              
            ),
        
        ],
      ),
      )
        ]
    )
   )
    );

  }
}



















    /* return Scaffold(
      appBar: AppBar(title: Text('Home'), actions: [FlatButton(onPressed: () => FirebaseAuth.instance.signOut(), child: Text('Logout'))],),
      body: Center(child: Text('Home Screen'),),
    );
  }
}
 */




