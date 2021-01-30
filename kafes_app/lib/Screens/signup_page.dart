import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafes_app/Screens/welcome_page.dart';
import 'package:kafes_app/Components/button_landing.dart';

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {

  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  var _mail = '';
  var _username = '';
  var _password = '';
  String _department;
  String _gender;
  var _number;
  String _fullName = '';
  UserCredential result;
  var _profilePic = '';

  void _submit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(isValid) {
      _formKey.currentState.save();
      try {
        result = await _auth.createUserWithEmailAndPassword(
            email: _mail, password: _password);
        result.user.sendEmailVerification();
        FirebaseFirestore.instance.collection('user').doc(result.user.uid)
            .set({
          'username': _username,
          'email': _mail,
          'department': _department,
          'gender': _gender,
          'id': _number,
          'fullName' : _fullName,
          'profilePic' : _profilePic,
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(
                builder: (BuildContext context) => WelcomePage()));
      }
      on FirebaseAuthException catch(error) {
        var warning = error.toString();
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(
            warning),),);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50.0,),
                child: TextFormField(
                  style: TextStyle(color: Colors.red),
                  key: ValueKey('username'),
                  validator: (value) {
                    if(value.isEmpty || value.length < 3 ) {
                      return 'Username length must be at least 3';
                    }
                    return null;
                  },
                  onSaved: (value){
                    _username = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter your username'
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50.0,),
                child: TextFormField(
                  style: TextStyle(color: Colors.red),
                  key: ValueKey('fullName'),
                  validator: (value) {
                    if(value.isEmpty || value.length < 5) {
                      return 'Must be 6 characters or more';
                    }
                    return null;
                  },
                  onSaved: (value){
                    _fullName = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter your full name',
                  ),
                ),
              ),
              Container (
                margin: EdgeInsets.symmetric(horizontal: 50.0),
                child: DropdownButton<String>(
                  hint: Text("Choose your department(optional)"),
                  isExpanded: true,
                  value: _department,
                  elevation: 8,
                  style: TextStyle(color: Colors.redAccent),
                  underline: Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  onChanged: (String newValue){
                    setState(() {
                      _department = newValue;
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
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50.0,),
                child: TextFormField(
                  style: TextStyle(color: Colors.red),
                  key: ValueKey('password'),
                  validator: (value) {
                    if(value.isEmpty || value.length < 7) {
                      return 'Password length must be at least 7';
                    }
                    return null;
                  },
                  onSaved: (value){
                    _password = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter your password',
                  ),
                  obscureText: true,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50.0,),
                child: TextFormField(
                  style: TextStyle(color: Colors.red),
                  key: ValueKey('email'),
                  validator: (value){
                    if(value.isEmpty || !value.contains('@std.ieu.edu.tr')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter your university mail'
                  ),
                  onSaved: (value) {
                    _mail = value;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50.0),
                child: DropdownButton<String>(
                    hint: Text("Choose gender(optional)"),
                    isExpanded: true,
                    value: _gender,
                    elevation: 8,
                    style: TextStyle(color: Colors.redAccent),
                    underline: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    onChanged: (String newValue){
                      setState(() {
                        _gender = newValue;
                      });
                    },
                    items: ["Male", "Female"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.red),
                  decoration: InputDecoration(
                      labelText: 'Enter your ID number(optional)'
                  ),
                  onSaved: (value) {
                    _number = value;
                  },
                )
              ),
              SizedBox(
                height: 50,
              ),
              ButtonLanding(
                buttonLabel: 'Sign Up',
                  onPress: () {
                  _submit();
                  }
                ),
            ],
          ),
        ),
      ),
    );
  }
}
