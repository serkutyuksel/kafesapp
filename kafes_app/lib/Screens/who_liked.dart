import 'package:flutter/material.dart';
import 'package:kafes_app/Components/user_flow.dart';

class WhoLiked extends StatefulWidget {
  WhoLiked({this.docId,this.uid});
  final docId;
  final uid;
  @override
  _WhoLikedState createState() => _WhoLikedState();
}


class _WhoLikedState extends State<WhoLiked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Likes'),
      ),
      body: Column(
        children: [
          UserFlow(uid: widget.uid, docId: widget.docId),
        ],
      ),
    );
  }
}
