import 'package:flutter/material.dart';
import 'package:kafes_app/Screens/edit_profile.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 70.0,
                    color: Colors.redAccent,
                    child: Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: Text('My Profile')
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 130.0,
                        width: 130.0,
                        margin: EdgeInsets.all(20.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/icon.jpg"),
                          radius: 50.0,
                          ),
                        ),
                      Container(
                        margin: EdgeInsets.all(25.0),
                        child: Column(
                          children: [
                            Text('@Username goes here'),
                            Text('Name Surname goes here'),
                            Text('Department goes here'),
                            Text('Email address goes here')
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(20.0),
                        color: Colors.redAccent,
                        width: 180.0,
                        height: 45.0,
                        child: TextButton(
                            onPressed: () {
                            Navigator.pushReplacement(
                              context,MaterialPageRoute(builder: (context) => EditProfile()),);},
                            child: Text('Edit Profile')
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
        )
    );
  }

}
