import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafes_app/button_landing.dart';
import 'package:kafes_app/Screens/profile_page.dart' ;

class SignUpPage extends StatefulWidget {
  SignUpPage(this.submitForm);
  final void Function(
      String mail,
      String username,
      String password,
      String department,
      BuildContext cnt,
      )submitForm;

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  var _mail = '';
  var _username = '';
  var _password = '';
  var _department = 'Computer Engineering';

  void _submit(){
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(isValid) {
      _formKey.currentState.save();
      widget.submitForm(
        _mail.trim(),
        _username.trim(),
        _password.trim(),
        _department.trim(),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
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
            Container (
              margin: EdgeInsets.symmetric(horizontal: 50.0),
              child: DropdownButton<String>(
                isExpanded: true,
                value: _department,
                elevation: 8,
                style: TextStyle(color: Colors.redAccent),
                underline: Container(
                  height: 1,
                  color: Colors.redAccent,
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
            ButtonLanding(
              buttonLabel: 'Sign Up',
                onPress: () {
                _submit();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ProfilePage()));
                }
              ),
          ],
        ),
      ),
    );
  }
}
