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
    print("MAIN BUILD");
    return MaterialApp(
        title: 'Free Feed',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot)  {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              print('COnnection STATE');
              return Center(
                child: Text('Waiting above'),
              );
            }
            if (userSnapshot.hasData) {
              print("Inside stream builder has data");
              final AuthService auth = AuthService();
              User user = userSnapshot.data;
              // auth.getUserData(user.uid).then(() {});
              return FutureBuilder(
                future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
                  builder: (ctx, futureSnapshot){
                if(futureSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text('Waiting here'));
                }
                print('Role:' + futureSnapshot.data.data()['role']);
                if(futureSnapshot.data.data()['role'] == 'ngo'){
                  return NGOHomeScreen();
                }
                return HomeScreen();
              });
            }
              print("ABOVE auth");
              return AuthScreen();
          },
        ));
  }
}
