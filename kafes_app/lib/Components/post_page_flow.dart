import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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

    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('post/$postID/comments').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot ){
          if(snapshot.hasError){
            return Text('Error: $snapshot.error');
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Text('Loading...');
          }
          return ListView(
            children: snapshot.data.docs.map((doc) => InkWell(
              onLongPress: (){
                commentOptions(context);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ListTile(
                  leading:  Icon(Icons.topic_rounded),
                  title: Container(
                    constraints: new BoxConstraints(
                      minHeight: 10.0,
                      maxHeight: 40.0,
                    ),
                    margin: EdgeInsets.all(10),
                    child: Text(doc['comment']),
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
              ),
            )).toList(),
          );
        },
      ),
    );
  }
}
