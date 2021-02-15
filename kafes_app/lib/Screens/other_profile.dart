import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafes_app/Screens/home_page.dart';
import 'package:kafes_app/Screens/profile_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kafes_app/Components/post_flow.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;



class OtherProfile extends StatefulWidget {

  OtherProfile({this.uid, this.otherUid});
  final String uid;
  final String otherUid;

  @override
  _OtherProfileState createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;
  var username = "";
  var email = "";
  var department = "";
  var fullName = "";
  var gender = "";
  String fileName;
  String imageUrl;
  bool imageLoading = false;

  @override
  void initState() {
    getUsername();
    getEmail();
    getDepartment();
    getFullName();
    getGender();
    getImageUrl();
    super.initState();
  }

    void getUsername() async {
    final userData = await _firestore.collection('user').doc(widget.otherUid).get();
    setState(() {
      username = userData.get('username');
    });
  }

  void getFullName() async {
    final userData = await _firestore.collection('user').doc(widget.otherUid).get();
    setState(() {
      fullName = userData.get('fullName');
    });
  }
  void getGender() async {
    final userData = await _firestore.collection('user').doc(widget.otherUid).get();
    setState(() {
      gender = userData.get('gender');
    });
  }

     void getEmail() async {
     final userData = await _firestore.collection('user').doc(widget.otherUid).get();
       setState(() {
         email = userData.get('email');
       });

  }

      void getDepartment() async {
      final userData = await _firestore.collection('user').doc(widget.otherUid).get();
       setState(() {
         department = userData.get('department');
       });

  }
  getImageUrl() async {
    setState(() {
      imageLoading = true;
    });
    final ref = storage.ref("profilePic").child(widget.otherUid);
    imageUrl = await ref.getDownloadURL();
    Timer(Duration(seconds: 1), () => setState(() {
      imageLoading = false;
    }),);

  }


  void customLaunch(command) async {
    if(await canLaunch(command)){
      await launch(command);
    }
    else{}
  }

  @override
  Widget build(BuildContext context) {
    if(widget.uid == widget.otherUid) {
      return ProfilePage(uid: widget.uid);
    }
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text("@$username", style: TextStyle(color: Colors.redAccent, fontFamily: 'BebasNeue', fontSize: 30.0,),),
            leading: IconButton(
              icon: Icon(CupertinoIcons.arrow_left_circle, color: Colors.redAccent, size: 30.0,),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomePage(uid: widget.uid)));
              },),),
            body: SafeArea(
              child: Column(
                children: [

                      Column(
                        children: [
                          Container(
                            height: 130.0,
                            width: 130.0,
                            margin: EdgeInsets.all(20.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(imageUrl==null?"https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png":imageUrl) ,
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
                      SizedBox(
                        width:10 ,
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
                          PostFlow(uid: widget.uid, isHomePage: false, otherUid: widget.otherUid, editProfile: false),
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




