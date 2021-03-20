import 'package:FreeFeed/screens/NGO/notification.dart';
import 'package:flutter/material.dart';
import 'donation.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:FreeFeed/widgets/custom_dialog.dart';

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}

class DonationTile extends StatelessWidget {
  final Donations donation;
  final id;
  DonationTile(this.donation, this.id);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right:
                              new BorderSide(width: 1.0, color: Colors.black))),
                  child: Icon(Icons.list_alt, color: Colors.black),
                ),
                title: Text(
                  // "Introduction to Driving",
                  "${donation.decription}",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.room_service_outlined),
                    Text(" ${donation.food_quantity} ",
                        style: TextStyle(color: Colors.black))
                  ],
                ),
                trailing: Icon(Icons.keyboard_arrow_down,
                    color: Colors.black, size: 30.0),
                onTap: () {
                  print("dialog clicked");
                  print(id);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBox(
                          id: id,
                          //title: "Custom Dialog Demo",
                          // descriptions: "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                          // text: "Yes",
                        );
                      });
                })));
  }
}
