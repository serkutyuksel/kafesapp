import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kafes_app/Screens/other_profile.dart';


class PostPageFlow extends StatelessWidget {

  PostPageFlow({this.uid, this.postID});
  final String uid;
  final String postID;


  commentOptions(BuildContext context) {
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        actions: <Widget>[
          MaterialButton(
            onPressed: (){
              },
            child: Text('Report comment!'),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('post/$postID/comments').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot ){
        if(snapshot.hasError){
          return Text('Error: $snapshot.error');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Text('Loading...');
        }
        return Expanded(
          child: ListView(
            children: snapshot.data.docs.map((doc) => Container(
              margin: EdgeInsets.all(5),
              child: ListTile(
                onLongPress: (){
                  commentOptions(context);
                },
                title: Container(
                  constraints: new BoxConstraints(
                    minHeight: 10.0,
                    maxHeight: 40.0,
                  ),
                  margin: EdgeInsets.all(10),
                  child: Text(doc['commentAuthorUsername']),
                ),
                subtitle: Container(
                  margin: EdgeInsets.all(10),
                  constraints: new BoxConstraints(
                    minHeight: 10.0,
                    maxHeight: 50.0,
                  ),
                  child: Text(doc['comment']),
                ),
              ),
            )).toList(),
          ),
        );
      },
    );
  }
}
