import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kafes_app/Screens/profile_page.dart';


class EditProfile extends StatefulWidget {
  final String uid;
  final String username;
  final String email;
  final String gender;
  final String fullName;
  String department;

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

  TextEditingController fullName, username,email,gender;
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
      "department" : widget.department,
    }).then((value) => Navigator.pushReplacement(context,
        MaterialPageRoute(
            builder: (BuildContext context) => ProfilePage(uid: widget.uid))));

  }


  @override
  void initState() {
   fullName = new TextEditingController(text: widget.fullName);
   username = new TextEditingController(text: widget.username);
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

