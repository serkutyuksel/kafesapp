import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostFlow extends StatelessWidget {
  const PostFlow();

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: StreamBuilder(
        stream: Firestore.instance.collection('post').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot ){
          if(snapshot.hasError){
            return Text('Error: $snapshot.error');
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Text('Loading...');
          }
          return ListView(
            children: snapshot.data.documents.map((doc) => Container(
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
                    child: Text(doc['postTitle']),
                ),
                subtitle: Container(
                  margin: EdgeInsets.all(10),
                  constraints: new BoxConstraints(
                    minHeight: 10.0,
                    maxHeight: 50.0,
                  ),
                  child: Text(doc['postBody']),
                ),
              ),
            )).toList(),
          );
        },

      ),
    );
  }
}
