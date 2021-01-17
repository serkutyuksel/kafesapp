import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kafes_app/Screens/post_page.dart';


class PostFlow extends StatelessWidget {

  PostFlow({this.uid});
  final String uid;

  postOptions(BuildContext context) {
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        actions: <Widget>[
          MaterialButton(
            onPressed: (){
              },
            child: Text('Report post!'),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('post').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot ){
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
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ListTile(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => PostPage(uid: uid, postID: doc.id,)));
                },
                onLongPress: (){
                  postOptions(context);
                },
                trailing: Container(
                  margin: EdgeInsets.all(10),
                  child: Text(doc['postAuthorUsername']),
                ),
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

class PostCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
