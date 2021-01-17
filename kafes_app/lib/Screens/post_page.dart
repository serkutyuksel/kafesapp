import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kafes_app/Components/post_page_flow.dart';

class PostPage extends StatefulWidget {

  PostPage({this.uid, this.postID});
  final String uid;
  final String postID;

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  var commentAuthorUsername = '';
  var postAuthorUsername = '';
  var postTitle = '';
  var postBody = '';
  var postDate = DateTime.now();
  String postTopic = 'Genel';


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
    final postData = await FirebaseFirestore.instance.collection('post').doc(widget.postID).get();
    setState(() {
      postTitle = postData.get('postTitle');
      postBody = postData.get('postBody');
      postDate = postData.get('postDate');
      postTopic = postData.get('postTopic');
      postAuthorUsername = postData.get('username');
    });
  }

  void getCommentAuthorUsername() async {
    final userData = await FirebaseFirestore.instance.collection('user').doc(widget.uid).get();
    setState(() {
      commentAuthorUsername = userData.get('username');
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.postID}'),
        backgroundColor: Colors.redAccent,
      ),
        body: Column(
          children: [
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
