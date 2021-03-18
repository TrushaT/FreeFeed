/* import 'dart:async';
import 'package:FreeFeed/screens/auth_screen.dart';
import 'package:FreeFeed/screens/home_screen.dart';
import 'package:FreeFeed/screens/ngo.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
@override
_SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
@override
void initState() {
	super.initState();
	Timer(Duration(seconds: 3),
		()=>Navigator.pushReplacement(context,
										MaterialPageRoute(builder:
														(context) => 
														AuthScreen()
														)
									)
		);
}
@override
Widget build(BuildContext context) {
	return Container(
	color: Colors.cyan[300],
	child: FlutterLogo(size:MediaQuery.of(context).size.height)
	);
}
}

 */