// import 'package:FreeFeed/screens/NGO/donationhistory.dart';
import 'package:FreeFeed/screens/NGO/homescreen.dart';
import 'package:FreeFeed/screens/authenticate/auth_screen.dart';
import 'package:FreeFeed/screens/users/chatswithngo.dart';
import 'package:FreeFeed/screens/users/drawerscreen.dart';
//import 'map_ngo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'chat_screen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
//import 'homepage.dart';
//import 'get_nearbyngo.dart';
import 'package:FreeFeed/models/NGO.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
//import 'donation_history.dart';
import 'ngo_history.dart';

class BottomNav extends StatefulWidget {
  final String role;

  BottomNav(this.role);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  PageController _pageController;
  List<NGO_User> nearbyngos;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    getPermissions();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  getPermissions() async {
    GeolocationStatus permissionStatus;
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FreeFeed'),
        backgroundColor: Colors.blue,
        actions: [
          FlatButton(
              child: Text('Logout'),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              }),
        ],
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            NGOHomeScreen(widget.role),
            
            DonationHistory(),
            ChatwithNgo(widget.role),
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
            title: Text('Donation Requests'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          /* BottomNavyBarItem(
            icon: Image.asset('assets/donate.png', width: 34, height: 34),
            // icon: Icon(Icons.map),
            title: Text('Donate'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ), */
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
