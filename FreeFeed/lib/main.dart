import 'package:FreeFeed/screens/NGO/homescreen.dart';
// import 'package:FreeFeed/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/authenticate/auth_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:FreeFeed/screens/users/map_ngo.dart';
import './screens/users/home_screen.dart';
import 'package:FreeFeed/widgets/auth_service.dart';
import 'package:FreeFeed/models/users.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Free Feed',
        theme: ThemeData(
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
              final AuthService auth = AuthService();
              User user = userSnapshot.data;
              // auth.getUserData(user.uid).then(() {});

              return NGOHomeScreen();
            }

            return AuthScreen();
          },
        ));
  }
}
