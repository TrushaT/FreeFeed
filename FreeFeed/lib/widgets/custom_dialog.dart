import 'dart:ui';
import 'dialog_constants.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  // final String title, descriptions, text;
  // // final Image img;

  // const CustomDialogBox({Key key, this.title, this.descriptions, this.text, this.img}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
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
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
              + Constants.padding, right: Constants.padding,bottom: Constants.padding
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(Constants.padding),
            boxShadow: [
              BoxShadow(color: Colors.black,offset: Offset(0,10),
              blurRadius: 10
              ),
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Date: 12/03/2021',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Text('Username: testuser1',style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                RaisedButton(
                   padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child:Text('Accept'),
                    ),
                     RaisedButton(
                        padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child:Text('Cancel'),
                    ),

                    ])
                    ),
            ],
          ),
        ),
      ],
    );
  }
}