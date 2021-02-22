import 'package:FreeFeed/screens/NGO/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/authenticate/auth_screen.dart';
import 'package:FreeFeed/screens/users/map_ngo.dart';
import 'package:FreeFeed/widgets/auth_service.dart';
import 'package:FreeFeed/models/users.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  getrole(u) async {


  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Free Feed',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot)  {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (userSnapshot.hasData) {
              final AuthService _auth = AuthService();
              User user = userSnapshot.data;
              dynamic role = _auth.getUserData(user.uid);
              if (role == 'ngo') {
                return HomeScreen() ;
              }
              return NGOLocation();
            }
            return AuthScreen();
          },
        ));
  }
}
