import 'package:cloud_firestore/cloud_firestore.dart';

class Donation {
  // final String uid;
  final String description;
  final String food_quantity;

  Donation(this.description, this.food_quantity);

  String toParams() => "?description=$description&food_quantity=$food_quantity";
}
