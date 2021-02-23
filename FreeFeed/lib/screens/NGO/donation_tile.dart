import 'package:flutter/material.dart';
import 'donation.dart';
class DonationTile extends StatelessWidget {
  final Donations donation;
  DonationTile(this.donation);

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text("${donation.decription}"))));
  
  }
}
