import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kafes_app/Screens/other_profile.dart';

class UserFlow extends StatefulWidget {
  UserFlow({this.docId,this.uid,this.isLike});
  final docId;
  final uid;
  final isLike;
  @override
  _UserFlowState createState() => _UserFlowState();
}

class _UserFlowState extends State<UserFlow> {
  CollectionReference docRef;

  void initState() {
    widget.isLike ? docRef = FirebaseFirestore.instance.collection('post')
        .doc(widget.docId).collection('liked') : docRef = FirebaseFirestore.instance
        .collection('post').doc(widget.docId).collection('applied');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
          stream: docRef.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              return Text('Error: $snapshot.error');
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Text('Loading...');
            }
            return ListView(
              children: snapshot.data.docs.map((doc) => Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => OtherProfile(uid: widget.uid, otherUid: doc.id.toString())),);
                      },
                      leading: Icon(Icons.alternate_email,size: 30,color: Colors.white,),
                      title: Container(
                        constraints: new BoxConstraints(
                          minHeight: 10.0,
                          maxHeight: 40.0,
                        ),
                        padding: EdgeInsets.all(5),
                        child: Text(widget.isLike?doc['isLiked']:doc['isApplied']),
                      ),
                    ),
                  ],
                ),
              )).toList(),
            );
          }
      ),
    );
  }
}
