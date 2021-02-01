import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:FreeFeed/widgets/donation_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:FreeFeed/models/donation.dart';
import 'package:FreeFeed/widgets/constants.dart';

class DonationForm extends StatefulWidget {

  @override
  _DonationFormState createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  String word;
  String description;
  String food_quantity;

  final _formKey = GlobalKey<FormState>();

  final textdescription = new TextEditingController();
  final textfood_quantity = new TextEditingController();
  Timestamp _dateTime;
  CustomToast toast = CustomToast();
  bool status;

  postData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("donations").doc();

    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();
    DateTime date = DateTime.now();

    Map<String, dynamic> product = {
      "userid": uid,
      "date_of_donation": date,
      "decription": description,
      "food_quantity": food_quantity,
      "ngoid": "tbd",
      "status": "requested",
    };
    documentReference.set(product).whenComplete(() => print("Posted Data!"));
    setState(() {
      word = documentReference.id;
    });
  }

    void _submitForm() {
      print('inside submitform');

      if (_formKey.currentState.validate()) {
        Donation donationForm =
            Donation(textdescription.text, textfood_quantity.text);
      }
    }


  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(
            title: Text("Donation Form"),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(

                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Please Enter Donation Description'),
                            controller: textdescription),
                        SizedBox(height: size.height * 0.03),
                        TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Please Enter Quantity'),
                            controller: textfood_quantity),
                        SizedBox(height: size.height * 0.04),
                        Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
                    RaisedButton(
                      color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                description = textdescription.text;
                                food_quantity = textfood_quantity.text;
                              });
                              postData();
                              _submitForm();
                              toast.showToast('Donation requested',
                                  Colors.green, Colors.white);
                            },
                            child: Text(
                              "Donation request",
                              style: TextStyle(color: Colors.white),
                            )
                            ),
                  ],)
                      ]
                      )
                      ),
            ),
          ),
        );
  }
}
