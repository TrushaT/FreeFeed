import 'package:FreeFeed/screens/authenticate/auth_screen.dart';
import 'package:FreeFeed/screens/users/drawerscreen.dart';
import 'package:FreeFeed/screens/users/ngodetails.dart';
import 'map_ngo.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'chat_screen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    print('Home screen user');
    return Scaffold(
            appBar: AppBar(
              title: const Text('FreeFeed'),
              backgroundColor: Colors.blue,
              actions: [
                FlatButton(
                  child: Text('Logout'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  }
                ),
              ],
            ),
            body:SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Container(color: Colors.white,),
           NGOLocation(),
           Container(color: Colors.white,),
             ChatScreen(),
          ],
        ),
      ),
    // drawer: UserDrawerScreen(),
    bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) {
        setState(() => _currentIndex = index);
         _pageController.jumpToPage(index);
         },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Image.asset('assets/donate.png',width:34,height:34),
            // icon: Icon(Icons.map),
            title: Text('Donate'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          
          BottomNavyBarItem(
            icon: Icon(Icons.assignment_turned_in),
            title: Text('History'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text(
              'Messages',
            ),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      
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




