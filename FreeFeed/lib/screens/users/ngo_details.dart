import 'package:flutter/material.dart';


class NgoDetails extends StatefulWidget {
  @override
  NgoDetailsState createState() => NgoDetailsState();
}

class NgoDetailsState extends State<NgoDetails> {

Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('NGO Details'),
              backgroundColor: Colors.cyan[300],
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                //background: ngo.png,
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 60.00,
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Ngo Name", style: TextStyle(fontSize: 40, color: Colors.black),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Ngo Details", style: TextStyle(fontSize: 24,color: Colors.black),),
                ),
               
              Padding(
                  padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  shape: StadiumBorder(),
                  child: Text("Chat"),
                  color: Colors.cyan[100],
                  onPressed: () {},
                ),),
              ]),
            )
          ],
        ),
      ),
    );
  }
}