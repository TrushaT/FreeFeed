import 'package:flutter/material.dart';
import 'package:FreeFeed/screens/users/chat_screen.dart';
import 'package:flutter/widgets.dart';

class ConversationList extends StatefulWidget {
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead = true;
  String userId;
  String ngoId;

  ConversationList(
      {@required this.name, @required this.messageText, @required this.imageUrl, @required this.time, @required this.userId, @required this.ngoId, bool isMessageRead});

  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ChatScreen(widget.userId, widget.ngoId)));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Image.asset(widget.imageUrl),
                    //backgroundImage: NetworkImage(widget.imageUrl),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name, style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(widget.messageText, style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: widget.isMessageRead
                                  ? FontWeight.bold
                                  : FontWeight.normal), overflow: TextOverflow.ellipsis,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(widget.time, style: TextStyle(fontSize: 12,
                fontWeight: widget.isMessageRead ? FontWeight.bold : FontWeight
                    .normal),),
          ],
        ),
      ),
    );
  }
}