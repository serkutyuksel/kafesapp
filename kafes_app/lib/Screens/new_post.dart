import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class NewPost extends StatefulWidget {

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {

  final _formKey = GlobalKey<FormState>();
  var postTitle = '';
  var postBody = '';

  void submitPost() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      FirebaseFirestore.instance.collection('post').doc().set(
          {'postTitle': postTitle, 'postBody': postBody}).whenComplete(() =>
          Navigator.of(context).pushNamed('/home'));
    }
  }





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("New Post"),
        backgroundColor: Colors.redAccent,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0,),
              child: TextFormField(
                style: TextStyle(color: Colors.red),
                key: ValueKey('postTitle'),
                validator: (value) {
                  if(value.isEmpty || value.length < 6 ) {
                    return 'Post Title length must be at least 6';
                  }
                  return null;
                },
                onSaved: (value){
                  postTitle = value;
                },
                decoration: InputDecoration(
                    labelText: 'Enter Post Title'
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0,),
              child: TextFormField(
                maxLines: 10,
                style: TextStyle(color: Colors.red),
                key: ValueKey('postBody'),
                validator: (value) {
                  if(value.isEmpty || value.length < 6 ) {
                    return 'Post Body length must be at least 6';
                  }
                  return null;
                },
                onSaved: (value){
                  postBody = value;
                },
                decoration: InputDecoration(
                    labelText: 'Enter Post Body'
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        submitPost();
      },
        child: Icon(Icons.add, color: Colors.redAccent,),
        backgroundColor: Colors.white,
        tooltip: "Post It",
      ),
    );
  }
}
