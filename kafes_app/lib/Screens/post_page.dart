import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kafes_app/Components/post_page_flow.dart';
import 'package:kafes_app/Screens/other_profile.dart';

class PostPage extends StatefulWidget {

  PostPage({this.uid, this.postID, this.focusComment});
  final String uid;
  final String postID;
  bool focusComment = false;

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  var commentAuthorUsername = '';
  var postAuthorUsername = '';
  var postTitle = '';
  var postBody = '';
  var postAuthorUid = '';
  String postTopic = 'General';
  var postData;
  var control = false;
  final TextEditingController _commentController = TextEditingController();
  CollectionReference _ref;
  FocusNode _focusNode;

  @override
  void initState() {
    getCommentAuthorUsername();
    getPostData();
    _ref = FirebaseFirestore.instance.collection('post/${widget.postID}/comments');
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void getPostData() async {
    postData = await FirebaseFirestore.instance.collection('post').doc(widget.postID).get();
    setState(() {
      postTitle = postData.get('postTitle');
      postBody = postData.get('postBody');
      postTopic = postData.get('postTopic');
      postAuthorUsername = postData.get('postAuthorUsername');
      postAuthorUid = postData.get('postAuthorUid');
    });
    Timer(Duration(seconds: 1), () => setState(() {
      control = true;
      })
    );
  }

  void getCommentAuthorUsername() async {
    final userData = await FirebaseFirestore.instance.collection('user').doc(widget.uid).get();
    setState(() {
      commentAuthorUsername = userData.get('username');
    });
  }


  @override
  Widget build(BuildContext context) {
    if(control == false) {
      return Scaffold(
        appBar: AppBar(
          title: Text('$postTitle'),
          backgroundColor: Colors.redAccent,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('$postTitle'),
        backgroundColor: Colors.redAccent,
      ),
        body: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => OtherProfile(uid: widget.uid, otherUid: postAuthorUid)),);
              },
              leading: CircleAvatar(
              ),
              title: Container(
                constraints: new BoxConstraints(
                  minHeight: 10.0,
                  maxHeight: 40.0,
                ),
                padding: EdgeInsets.all(5),
                child: Text('$postAuthorUsername'),
              ),
            ),
            ListTile(
              title: Container(
                constraints: new BoxConstraints(
                  minHeight: 10.0,
                  maxHeight: 40.0,
                ),
                margin: EdgeInsets.all(5),
                child: Text(postTitle, style: TextStyle(fontSize: 18),),
              ),
              subtitle: Container(
                constraints: new BoxConstraints(
                  minHeight: 10.0,
                  maxHeight: 45.0,
                ),
                margin: EdgeInsets.all(5),
                child: Text(postBody),
              ),
            ),
            ListTile(
              title: Container(
                constraints: new BoxConstraints(
                  minHeight: 10.0,
                  maxHeight: 40.0,
                ),
                margin: EdgeInsets.all(5),
                child: Text("#" + postTopic, style: TextStyle(fontSize: 15, color: Colors.blue),),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                      color: Colors.redAccent,
                      child: Text("Apply This Project"),
                      onPressed: (){}
                  ),
                ],),
            ),
            PostPageFlow(uid: widget.uid, postID: widget.postID,),
            Row(
              children: [
                Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25),),
                    border: Border.all(width: 2, color: Colors.redAccent)
                  ),
                  child: TextField(
                    autofocus: widget.focusComment,
                    focusNode: _focusNode,
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Type a comment',
                      border: InputBorder.none,
                    ),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(right: 10,),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.redAccent),
                  child: IconButton(
                      icon: Icon(Icons.send, color: Colors.white,),
                      onPressed: () async{
                    await _ref.add({
                      'commentAuthorId': widget.uid,
                      'commentAuthorUsername': commentAuthorUsername,
                      'comment': _commentController.text,
                      'commentDate': DateTime.now()
                    });
                    _commentController.text = '';
                    _focusNode.unfocus();
                  }),
                )
              ],
            ),
          ],
        ),
    );
  }
}
