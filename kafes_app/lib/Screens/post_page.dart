import 'package:flutter/material.dart';
import 'package:kafes_app/Components/post_page_flow.dart';

class PostPage extends StatelessWidget {

  PostPage({this.uid, this.postID});
  final String uid;
  final String postID;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$postID'),
        backgroundColor: Colors.redAccent,
      ),
        body: Column(
          children: [
            Container(height: 100,),
            PostPageFlow(uid: uid, postID: postID,),
          ],
        ),

    );
  }
}
