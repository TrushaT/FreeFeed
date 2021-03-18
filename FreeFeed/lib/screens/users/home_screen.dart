import 'package:FreeFeed/screens/authenticate/auth_screen.dart';
import 'package:FreeFeed/screens/users/drawerscreen.dart';
import 'map_ngo.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Home screen user');
    return Scaffold(
            appBar: AppBar(
              title: const Text('FreeFeed'),
              backgroundColor: Colors.cyan[300],
              actions: [
                /* FlatButton(
                  child: Text('Locate NGO'),
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => NGOLocation())),
                ),
                 FlatButton(
                  child: Text('Chat'),
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => ChatScreen())),
                ),*/
                FlatButton(
                  child: Text('Logout'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
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
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  'Fav ngos will come here',
                  style: TextStyle(
                    color: Colors.black,
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
    ),
    drawer: UserDrawerScreen(),
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




