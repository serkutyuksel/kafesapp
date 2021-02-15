import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kafes_app/Screens/profile_page.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class EditProfile extends StatefulWidget {
  final String uid;
  final String username;
  final String email;
  final String gender;
  final String fullName;
  String department;
  String imageUrl;

  EditProfile({
    this.uid,
    this.username,
    this.email,
    this.gender,
    this.fullName,
    this.department,
    this.imageUrl,

  });


  @override
  _EditProfileState createState() => _EditProfileState();
}


class _EditProfileState extends State<EditProfile> {

  File _image;
  final picker = ImagePicker();
  String fileName;
  String imageUrl;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  bool imageLoading = false;

  getImageUrl() async {
    setState(() {
      imageLoading = true;
    });
    final ref = storage.ref("profilePic").child(widget.uid);
    imageUrl = await ref.getDownloadURL();
    Timer(Duration(seconds: 1), () => setState(() {
      imageLoading = false;
    }),);

  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
        _image = File(pickedFile.path);
        imageUrl = getImageUrl();
    });
  }
  Future<void> uploadFile() async {
    fileName = widget.uid;
    if (storage.ref("profilePic").child(fileName) == null){
    await storage.ref("profilePic/$fileName").putFile(_image);
    }
    else {
      await storage.ref("profilePic/$fileName").delete().whenComplete(() => storage.ref("profilePic/$fileName").putFile(_image));
    }
    setState(() {
      imageUrl = getImageUrl();
    });
  }

  changeProfilePic() {
    getImage().whenComplete(() => uploadFile().whenComplete(() => getImageUrl()));
  }



  TextEditingController fullName, username,email,gender;
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  var newUsername = "";
  var newFullName= "";

  void _submit () async {
    final isValid = _formKey.currentState.validate();
    if(isValid) {
      _formKey.currentState.save();
      FocusScope.of(context).unfocus();
      await _firestore.collection('user').doc(widget.uid).update({
        "username": newUsername,
        "fullName": newFullName,
        "department": widget.department,
      }).then((value) =>
          Navigator.pushReplacement(context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ProfilePage(uid: widget.uid))));
    }
  }


  @override
  void initState() {
    fullName = new TextEditingController(text: widget.fullName);
    username = new TextEditingController(text: widget.username);
    gender = new TextEditingController(text: widget.gender);
    email = new TextEditingController(text: widget.email);
    imageUrl = widget.imageUrl;

  }


  @override
  Widget build(BuildContext context) {
    if(imageLoading == true) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
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
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl==null?"https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png":imageUrl),
                    radius: 50.0,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: changeProfilePic,
                      color: Colors.white70,
                      icon: Icon(
                        Icons.photo,
                      )
                    )
                  ),
                ),
                SizedBox(
                  height: 15,
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
                Container (
                  margin: EdgeInsets.symmetric(horizontal: 50.0),
                  child: DropdownButton<String>(
                      hint: Text("Choose your department"),
                      isExpanded: true,
                      value: widget.department,
                      elevation: 8,
                      style: TextStyle(color: Colors.redAccent),
                      underline: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      onChanged: (String newValue){
                        setState(() {
                          widget.department = newValue;
                        });
                      },
                      items: ["Computer Engineering","Software Engineering","Aerospace Engineering",
                        "Biomedical Engineering","Civil Engineering", "Electrical and Electronics Engineering",
                        "Food Engineering", "Genetics and Bioengineering", "Industrial Engineering",
                        "Mechanical Engineering", "Mechatronics Engineering", "Mathematics", "Physics",
                        "English Translation and Interpreting", "Psychology", "Sociology", "Architecture",
                        "Industrial Design", "Interior Architecture and Environmental Design", "Textile and Fashion Design",
                        "Visual Communication Design", "Law", "Cinema and Digital Media", "New Media and Communication",
                        "Public Relations and Advertising", "Accounting and Auditing Program", "Business Administration",
                        "Economics", "International Trade and Finance", "Logistics Management", "Health Management", "Nursing",
                        "Medicine",]
                          .map<DropdownMenuItem<String>>((String newValue) {
                        return DropdownMenuItem<String>(
                          value: newValue,
                          child: Text(newValue),
                        );
                      }).toList()
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0,),
                  child: TextFormField(
                    enabled: false,
                    controller: email,
                    style: TextStyle(color: Colors.grey),
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
                    style: TextStyle(color: Colors.grey),
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

