import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kafes_app/Screens/post_page.dart';


class PostFlow extends StatefulWidget {

  PostFlow({this.uid});
  final String uid;

  @override
  _PostFlowState createState() => _PostFlowState();
}

class _PostFlowState extends State<PostFlow> {

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
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                    ),
                    title: Container(
                      constraints: new BoxConstraints(
                        minHeight: 10.0,
                        maxHeight: 40.0,
                      ),
                        padding: EdgeInsets.all(5),
                        child: Text(doc['postAuthorUsername']),
                    ),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => PostPage(uid: widget.uid, postID: doc.id, focusComment: false,)));
                    },
                    onLongPress: (){
                      postOptions(context);
                    },
                    title: Container(
                      constraints: new BoxConstraints(
                        minHeight: 10.0,
                        maxHeight: 40.0,
                      ),
                      margin: EdgeInsets.all(5),
                      child: Text(doc['postTitle'], style: TextStyle(fontSize: 18),),
                    ),
                    subtitle: Container(
                      constraints: new BoxConstraints(
                        minHeight: 10.0,
                        maxHeight: 45.0,
                      ),
                      margin: EdgeInsets.all(5),
                      child: Text(doc['postBody']),
                    ),

                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.favorite),
                              iconSize: 30,
                            ),
                            IconButton(
                              icon: Icon(Icons.comment),
                              iconSize: 30,
                              onPressed: (){
                                Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => PostPage(uid: widget.uid, postID: doc.id, focusComment: true,)));
                              },
                            ),
                          ],
                        ),
                      MaterialButton(
                          color: Colors.white,
                          child: Text("Apply"),
                          onPressed: (){}

                      ),
                    ],),
                  ),
                ],
              ),
            )).toList(),
          );
        },

      ),
    );
  }
}
