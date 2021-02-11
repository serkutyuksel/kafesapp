import 'package:flutter/material.dart';
import 'package:kafes_app/Components/post_flow.dart';

class EditPage extends StatefulWidget {
  EditPage({this.uid});
  final uid;
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Edit Posts"),
      ),
      body: Column(
        children:[ Expanded(
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, innerBoxIsScrolled){
              return[
                SliverAppBar(
                  floating: true,
                  snap: true,
                  title: Text('Delete or edit your posts', style: TextStyle(color: Colors.redAccent),),
                  backgroundColor: Colors.white,
                )
              ];
            },
            body: Column(
              children: [
                PostFlow(uid: widget.uid, isHomePage: false, otherUid: widget.uid, editProfile: true),
              ],
            ),),
        ),
        ]
      ),
    );
  }
}
