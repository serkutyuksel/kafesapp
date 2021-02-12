import 'package:flutter/material.dart';
import 'package:kafes_app/Components/user_flow.dart';

class WhoApplied extends StatefulWidget {
  WhoApplied({this.docId,this.uid});
  final docId;
  final uid;
  @override
  _WhoAppliedState createState() => _WhoAppliedState();
}


class _WhoAppliedState extends State<WhoApplied> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Applicants'),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, innerBoxIsScrolled){
          return[
            SliverAppBar(
              floating: true,
              snap: true,
              title: Text("Applies Sent by", style: TextStyle(color: Colors.redAccent),),
              backgroundColor: Colors.white,
            )
          ];
        },
        body: Column(
          children: [
            UserFlow(uid: widget.uid, docId: widget.docId,isLike: false),
          ],
        ),
      ),
    );
  }
}
