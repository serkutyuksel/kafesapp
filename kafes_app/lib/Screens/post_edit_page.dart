import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kafes_app/Screens/profile_page.dart';

class PostEdit extends StatefulWidget {
  PostEdit({this.docId, this.uid});
  final String docId;
  final String uid;
  @override
  _PostEditState createState() => _PostEditState();
}

class _PostEditState extends State<PostEdit> {
  TextEditingController postTitle, postBody;
  final _formKey = GlobalKey<FormState>();
  var newTitle = "";
  var newBody = "";
  var control = false;
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    final docRef = FirebaseFirestore.instance.collection('post').doc(widget.docId);
    final docSnap = await docRef.get();
    final docData = docSnap.data();
    postTitle = new TextEditingController(text: docData['postTitle']);
    postBody = new TextEditingController(text: docData['postBody']);
    Timer(Duration(seconds: 1), () => setState(() {
      control = true;
    })
    );
  }

  void _submit() async {
    final isValid = _formKey.currentState.validate();
    if(isValid) {
      _formKey.currentState.save();
      FocusScope.of(context).unfocus();
      final docRef = FirebaseFirestore.instance.collection('post').doc(
          widget.docId);
      await docRef.update({'postTitle': newTitle, 'postBody': newBody}).then((value) =>
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) =>
              ProfilePage(uid: widget.uid)))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if(control == false) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Edit your post'),
          backgroundColor: Colors.redAccent,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit your post"),
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0),
                  child: TextFormField(
                    controller: postTitle,
                    style: TextStyle(color: Colors.red),
                    key: ValueKey('title'),
                    validator: (value) {
                      if (value.length < 6 || value.isEmpty) {
                        return 'Post Title length must be at least 6';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                        newTitle = value;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0),
                  child: TextFormField(
                    maxLines: 10,
                    controller: postBody,
                    style: TextStyle(color: Colors.red),
                    key: ValueKey('body'),
                    validator: (value) {
                      if (value.length < 6 || value.isEmpty) {
                        return 'Post Body length must be at least 6';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                        newBody = value;
                    },
                  ),
                ),
                MaterialButton(
                    color: Colors.redAccent,
                    child: Text("Save Changes"),
                    onPressed: _submit
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
