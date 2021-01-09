import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


DocumentSnapshot snapshot;

class ProfilePage extends StatefulWidget {

  ProfilePage({this.uid});
  final String uid;


  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _firestore = FirebaseFirestore.instance;
  var username = "";
  var email = "";
  var department = "";

  @override
  void initState() {
    getUsername();
    getEmail();
    getDepartment();
  }

    void getUsername() async {
    final userData = await _firestore.collection('user').doc(widget.uid).get();
    setState(() {
      username = userData.get('username');
    });
  }

     void getEmail() async {
     final userData = await _firestore.collection('user').doc(widget.uid).get();
       setState(() {
         email = userData.get('email');
       });

  }

      void getDepartment() async {
      final userData = await _firestore.collection('user').doc(widget.uid).get();
       setState(() {
         department = userData.get('department');
       });

  }

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
                        child: Text(
                          'My Profile',
                          style: TextStyle(fontFamily: 'BebasNeue', fontSize: 30.0),)
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
                      Expanded(
                        child:((() {
                          while (username != null && email != null && department != null){
                            return Column(
                              children: [
                                Text(username),
                                Text(department),
                                Text(email),
                              ],
                            );
                          }
                        } )())
                        ),
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
                            onPressed: () {},
                            child: Text('Edit Profile'),
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

//Navigator.pushReplacement(
//context,MaterialPageRoute(builder: (context) => EditProfile()),);


