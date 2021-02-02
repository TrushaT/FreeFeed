// Push Notification Implementation


import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';

// handle the received push notification when the app in the background.
Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

// extracts the JSON body payload from the FCM push notification.
final Map<String, Donation> _donations = <String, Donation>{};
Donation _donationForMessage(Map<String, dynamic> message) {
  final dynamic data = message['data'] ?? message;
  final String donationId = data['id'];
  final Donation donation = _donations.putIfAbsent(donationId, () => Donation(donationId: donationId))
    .._userid = data['userid']
    .._donationid = data['donationid'];
  return donation;
}

class Donation {
  Donation({this.donationId});
  final String donationId;

  StreamController<Donation> _controller = StreamController<Donation>.broadcast();
  Stream<Donation> get onChanged => _controller.stream;

  String _userid;
  String get userid => _userid;
  set userid(String value) {
    _userid = value;
    _controller.add(this);
  }

  String _donationid;
  String get score => _donationid;
  set donation(String value) {
    _donationid = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};
  Route<void> get route {
    final String routeName = '/detail/$donationId';
    return routes.putIfAbsent(
      routeName,
          () => MaterialPageRoute<void>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => DetailPage(donationId),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  DetailPage(this.itemId);
  final String itemId;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Donation _donation;
  StreamSubscription<Donation> _subscription;

  @override
  void initState() {
    super.initState();
    _donation = _donations[widget.itemId];
    _subscription = _donation.onChanged.listen((Donation donation) {
      if (!mounted) {
        _subscription.cancel();
      } else {
        setState(() {
          _donation = donation;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donation ID ${_donation.donationId}"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Card(
            child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        children: <Widget>[
                          Text('Today match:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                          Text( _donation.userid, style: Theme.of(context).textTheme.title)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        children: <Widget>[
                          Text('Score:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                          Text( _donation.donationId, style: Theme.of(context).textTheme.title)
                        ],
                      ),
                    ),
                  ],
                )
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}