import 'package:cloud_firestore/cloud_firestore.dart';

class General_User {
  final String uid;
  final String username;
  final String email;
  final String role;
  
  General_User(
    {
      this.uid,
      this.username,
      this.email,
      this.role
    }
  );
}
