import 'package:FreeFeed/screens/authenticate/auth_screen.dart';
import 'package:FreeFeed/screens/users/drawerscreen.dart';
import 'package:FreeFeed/screens/users/ngodetails.dart';
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
                FlatButton(
                  child: Text('Locate NGO'),
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => NGOLocation())),
                ),
                 /*FlatButton(
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
            body: GridView.builder(
          itemCount: 8,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 8.0 / 10.0,
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.all(5),
                child: Card(
                    semanticContainer: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      splashColor: Colors.cyan[100],
                      onTap:  () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => NgoDetails()));
                      },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                              "NGO Name",
                              style: TextStyle(fontSize: 18.0),
                            ),
                        Text(
                              "NGO details",
                              style: TextStyle(fontSize: 12.0),
                            ) 
                          ],
                      ),
                      
                    )));
          },
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




