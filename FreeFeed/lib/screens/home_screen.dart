import 'package:FreeFeed/screens/auth_screen.dart';
import 'package:FreeFeed/screens/ngo.dart';
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




