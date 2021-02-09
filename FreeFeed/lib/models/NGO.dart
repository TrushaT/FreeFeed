import 'package:cloud_firestore/cloud_firestore.dart';

class NGO_User {
  final String uid;
  final String username;
  final String latitude;
  final String longitude;
  final String role;
  final String email;
  final String donationlistid;
  NGO_User(
      {this.uid,
      this.username,
      this.latitude,
      this.longitude,
      this.role,
      this.email,
      this.donationlistid});
}
