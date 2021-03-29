import 'dart:ui';
import 'dialog_constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'donation_toast.dart';
import 'package:FreeFeed/screens/users/home_screen.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'dart:convert';

class CustomDialogBox extends StatefulWidget {
  final id;
  final date;
  final username;

  const CustomDialogBox({Key key, this.id, this.date, this.username})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  var postUrl = "https://fcm.googleapis.com/fcm/send";

  final FirebaseAuth auth = FirebaseAuth.instance;
  CustomToast toast = CustomToast();
  String username;

  @override
  void dispose() {
    super.dispose();
  }

  getcurrentngoid() {
    final User user = auth.currentUser;
    final ngoid = user.uid;
    return ngoid;
  }

  getngo() async {
    DocumentSnapshot ref = await FirebaseFirestore.instance
        .collection('donations')
        .doc(widget.id)
        .get();
    print(ref.data()['ngoid']);
    return ref.data()['ngoid'];
  }

  getngoname(ngo) async {
    DocumentSnapshot ref = await FirebaseFirestore.instance
        .collection('users')
        .doc(ngo)
        .get();
    print(ref.data()['username']);
    return ref.data()['username'];
  }

  Future<void> sendNotification(ngo) async {
    var token = await getToken();
    var ngo_name = await getngoname(ngo);

    print('token : $token');

    try {
      var data = {
        "notification": {
          "body": " $ngo_name has accepted your request",
          "title": "Donation Request accepted !",
        },
        "priority": "high",
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "id": "1",
          "status": "done"
        },
        "to": "$token"
      };

      final headers = {
        'content-type': 'application/json',
        'Authorization':
            'key=AAAA_4hFHRA:APA91bGtA6Z8GbOdjXitBDyVwCDbum7xG1CxM0qu_6Qb5O43cOI5flqL3s0h4vMpSwVWLE_0v-np2Jdgmi7kwdSt0AeMYosGPr3Ib3mvwrclGSWXCfiVcL6f8T5kliuCsKhd8KkxY35T'
      };

      var client = new Client();
      var response =
          await client.post(postUrl, headers: headers, body: json.encode(data));
      print(response.body);
    } catch (e) {
      print(e);
    }

  
  }

  Future<String> getToken() async {
    var token;
    DocumentSnapshot ref = await FirebaseFirestore.instance
        .collection('donations')
        .doc(widget.id)
        .get();

    token = ref.data()['token'];
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    String ngo;
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Date : ${widget.date.toDate().toString().split(" ")[0]}\nTime : ${widget.date.toDate().toString().split(" ")[1].substring(0, 5)}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                ' Username: ${widget.username}',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          padding: const EdgeInsets.all(8.0),
                          textColor: Colors.white,
                          color: Colors.green,
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('donations')
                                .doc(widget.id)
                                .update({
                              'status': "accepted",
                              'ngoid': getcurrentngoid(),
                            });
                            ngo = await getngo();
                            if (ngo == getcurrentngoid()) {
                              sendNotification(ngo);
                              toast.showToast('Donation request accepted',
                                  Colors.blue, Colors.white);
                            } else {
                              toast.showToast(
                                  'Sorry ! Request accepted by another Ngo',
                                  Colors.red,
                                  Colors.white);
                            }

                            Navigator.of(context).pop();
                          },
                          child: Text('Accept'),
                        ),
                        RaisedButton(
                          padding: const EdgeInsets.all(8.0),
                          textColor: Colors.white,
                          color: Colors.red,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                      ])),
            ],
          ),
        ),
      ],
    );
  }
}
