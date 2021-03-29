import 'package:FreeFeed/screens/authenticate/auth_screen.dart';
import 'package:FreeFeed/screens/users/chatswithngo.dart';
import 'package:FreeFeed/screens/users/drawerscreen.dart';
import 'package:FreeFeed/screens/users/ngodetails.dart';
import 'map_ngo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'homepage.dart';
import 'get_nearbyngo.dart';
import 'package:FreeFeed/models/NGO.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
// import 'donation_history.dart';
import 'donationhistory.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';


class HomeScreen extends StatefulWidget {
  final String role;

  HomeScreen(this.role);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController _pageController;
  List<NGO_User> nearbyngos;
  final FirebaseMessaging fcm = FirebaseMessaging();

  @override
  void initState() {
    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
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
            HomePage(),
            NGOLocation(),
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
            title: Text('Home'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Image.asset('assets/donate.png', width: 34, height: 34),
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
