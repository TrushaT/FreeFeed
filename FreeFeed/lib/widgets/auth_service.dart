import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:FreeFeed/models/users.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  General_User u;

  General_User _userFromFirebaseUser(DocumentSnapshot querySnapshot) {
    String uid = querySnapshot.data()['uid'];
    String username = querySnapshot.data()['username'];
    String email = querySnapshot.data()['email'];
    String role = querySnapshot.data()['role'];
    return General_User(uid: uid, username: username, email: email, role: role);
  }

  Future getUserData(String uid) async {
        DocumentReference ref = userCollection.doc(uid);
       try {
      await ref.get().then((querySnapshot) async {
        // print("Here 1");
        this.u = _userFromFirebaseUser(querySnapshot);
        return this.u.role;
      });
      return this.u;
    } catch (e) {
      return null;
    }
  }
}
