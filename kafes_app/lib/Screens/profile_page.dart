import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kafes_app/Screens/edit_profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kafes_app/Components/post_flow.dart';



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
  var fullName = "";
  var gender = "";
  var profilePic = "";

  @override
  void initState() {
    getUsername();
    getEmail();
    getDepartment();
    getFullName();
    getGender();
    getProfilePic();
  }

    void getUsername() async {
    final userData = await _firestore.collection('user').doc(widget.uid).get();
    setState(() {
      username = userData.get('username');
    });
  }

  void getFullName() async {
    final userData = await _firestore.collection('user').doc(widget.uid).get();
    setState(() {
      fullName = userData.get('fullName');
    });
  }
  void getGender() async {
    final userData = await _firestore.collection('user').doc(widget.uid).get();
    setState(() {
      gender = userData.get('gender');
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

  void getProfilePic() async {
    final userData = await _firestore.collection('user').doc(widget.uid).get();
    setState(() {
      profilePic = userData.get('profilePic');
    });

  }

  void customLaunch(command) async {
    if(await canLaunch(command)){
      await launch(command);
    }
    else{}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                        margin: EdgeInsets.only(top: 30.0, bottom: 10.0),
                        alignment: Alignment.center,
                        child: Text(
                          'My Profile',
                          style: TextStyle(fontFamily: 'BebasNeue', fontSize: 30.0, color: Colors.redAccent),)
                    ),
                      Column(
                        children: [
                          Container(
                            height: 130.0,
                            width: 130.0,
                            margin: EdgeInsets.all(20.0),
                            child: CircleAvatar(
                              backgroundImage: AssetImage("assets/images/icon.jpg") ,
                              radius: 50.0,
                              ),
                            ),
                          Container(
                             padding: EdgeInsets.all(20),
                              child:((() {
                                while (username != null && email != null && fullName != null ){
                                  return Column(
                                    children: [
                                      Text(username),
                                      Text(fullName),
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
                       RaisedButton(
                          color: Colors.redAccent,
                            onPressed: () {
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => EditProfile(uid: widget.uid, username: username, email: email, fullName: fullName,department: department, gender: gender,)),);
                            },
                            child: Text('Edit Profile'),
                        ),
                      SizedBox(
                        width:10 ,
                      ),
                      RaisedButton(
                        padding: EdgeInsets.all(10),
                        color: Colors.redAccent,
                        onPressed: () {
                          customLaunch('mailto:$email');
                        },
                        child: Text('Send E-mail'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: NestedScrollView(

                      headerSliverBuilder: (BuildContext context, innerBoxIsScrolled){
                        return[
                          SliverAppBar(
                            floating: true,
                            snap: true,
                            title: Text('Latest Posts by @$username', style: TextStyle(color: Colors.redAccent),),
                            backgroundColor: Colors.white,
                          )
                        ];
                      },
                      body: Column(
                        children: [
                          PostFlow(uid: widget.uid,),
                        ],
                      ),),
                  ),
                ],
              ),
            )
        )
    );
  }
}




