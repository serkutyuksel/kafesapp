import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kafes_app/Screens/profile_page.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final String uid;
  final String username;
  final String email;
  final String gender;
  final String fullName;
  final String department;

  EditProfile({
    this.uid,
    this.username,
    this.email,
    this.gender,
    this.fullName,
    this.department,

  });


  @override
  _EditProfileState createState() => _EditProfileState();
}


class _EditProfileState extends State<EditProfile> {

  TextEditingController fullName, username,department,email,gender;
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  var newUsername = "";
  var newFullName= "";

  void _submit () async {
    final isValid = _formKey.currentState.validate();
    if(isValid) {
      _formKey.currentState.save();}
    FocusScope.of(context).unfocus();
    await _firestore.collection('user').doc(widget.uid).update({
      "username" : newUsername,
      "fullName" : newFullName,
    }).then((value) => Navigator.pushReplacement(context,
        MaterialPageRoute(
            builder: (BuildContext context) => ProfilePage(uid: widget.uid))));

  }


  @override
  void initState() {
   fullName = new TextEditingController(text: widget.fullName);
   username = new TextEditingController(text: widget.username);
   department = new TextEditingController(text: widget.department);
   gender = new TextEditingController(text: widget.gender);
   email = new TextEditingController(text: widget.email);

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  //TODO: ADD PROFILE PICTURE EDITING
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0,),
                  child: TextFormField(
                    controller: username,
                    style: TextStyle(color: Colors.red),
                    key: ValueKey('username'),
                    validator: (value) {
                      if(value.isEmpty || value.length < 3 ) {
                        return 'Username length must be at least 3';
                      }
                      return null;
                    },
                    onSaved: (value){
                      newUsername = value;
                    },
                    decoration: InputDecoration(
                      labelText: ("Edit your username"),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0,),
                  child: TextFormField(
                    controller: fullName,
                    style: TextStyle(color: Colors.red),
                    key: ValueKey('fullName'),
                    onSaved: (value){
                      newFullName = value;
                    },
                    decoration: InputDecoration(
                      labelText: ("Edit your name"),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0,),
                  child: TextFormField(
                    enabled: false,
                    controller: department,
                    style: TextStyle(color: Colors.red),
                    decoration: InputDecoration(
                      labelText: ('Department can not be edited'),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0,),
                  child: TextFormField(
                    enabled: false,
                    controller: email,
                    style: TextStyle(color: Colors.red),
                    decoration: InputDecoration(
                      labelText: ('E-mail can not be edited'),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0,),
                  child: TextFormField(
                    enabled: false,
                    controller: gender,
                    style: TextStyle(color: Colors.red),
                    decoration: InputDecoration(
                      labelText: ('Gender can not be edited'),
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: _submit,
                  textColor: Colors.redAccent,
                  child: Text('Save Profile'),
                )
              ],
            ),
          ),
        ),
      ),
       );
  }
}

