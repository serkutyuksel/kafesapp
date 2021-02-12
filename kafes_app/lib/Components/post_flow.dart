import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kafes_app/Screens/other_profile.dart';
import 'package:kafes_app/Screens/post_edit_page.dart';
import 'package:kafes_app/Screens/post_page.dart';
import 'package:kafes_app/Screens/who_liked.dart';

class PostFlow extends StatefulWidget {

  PostFlow({this.uid,this.isHomePage,this.otherUid,this.editProfile});
  final String uid;
  final bool isHomePage;
  final String otherUid;
  final bool editProfile;
  @override
  _PostFlowState createState() => _PostFlowState();
}

class _PostFlowState extends State<PostFlow> {

  void deleteDialog(String docID, String postName) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you sure?", style: TextStyle(color: Colors.redAccent),),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("Really Want to Delete This Post?: "),
                  Text(postName),
                ],
              ),
            ),
            actions: [
              TextButton(
                  child: Text("Delete", style: TextStyle(color: Colors.redAccent),),
                  onPressed: () async{
                    await FirebaseFirestore.instance.collection('post').doc(docID).delete();
                    Navigator.of(context).pop();
                  }
              ),
              TextButton(
                child: Text("Cancel", style: TextStyle(color: Colors.redAccent),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }
  var username;
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
  void initState() {
    getUsername();
    super.initState();
  }

  void getUsername() async {
    final userData = await FirebaseFirestore.instance.collection('user').doc(widget.uid).get();
    username = userData.get('username');
  }

  @override
  Widget build(BuildContext context) {
    if(!widget.isHomePage && widget.editProfile){
      final CollectionReference myCollection = FirebaseFirestore.instance
          .collection('post');
      final Query myQuery = myCollection.where('postAuthorUid', isEqualTo: widget.otherUid);
      return Expanded(
        child: StreamBuilder(
          stream: myQuery.snapshots(),
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
                      onTap: () {
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => OtherProfile(uid: widget.uid, otherUid: doc["postAuthorUid"])),);
                      },
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
                                builder: (BuildContext context) => PostPage(uid: widget.uid, postID: doc.id, focusComment: false, user: username,)));
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
                                  onPressed: () async {
                                    var control = false;
                                    await FirebaseFirestore.instance.collection('post').
                                    doc(doc.id).collection('liked').get().then((queryLike) =>
                                    {
                                      queryLike.docs.forEach((element) {
                                        if(element.id == widget.uid) {
                                          FirebaseFirestore.instance.collection('post').
                                          doc(doc.id).collection('liked').doc(widget.uid).delete();
                                          FirebaseFirestore.instance.collection('post').doc(doc.id)
                                              .update({'likes': doc['likes'] - 1});
                                          control = true;
                                        }
                                      })
                                    }
                                    );
                                    if(control == false) {
                                      FirebaseFirestore.instance.collection('post')
                                          .doc(doc.id).collection('liked').doc(widget.uid)
                                          .set({'isLiked': username});
                                      FirebaseFirestore.instance.collection('post').doc(doc.id)
                                          .update({'likes': doc['likes'] + 1});
                                    }
                                  }
                              ),
                              Text(doc['likes'].toString()),
                              IconButton(
                                icon: Icon(Icons.comment),
                                iconSize: 30,
                                onPressed: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) => PostPage(uid: widget.uid, postID: doc.id, focusComment: true, user: username)));
                                },
                              ),
                            ],
                          ),
                          MaterialButton(
                            color: Colors.white,
                            child: Text("Like Details"),
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => WhoLiked(uid: widget.uid, docId: doc.id)));
                            },
                          ),
                          MaterialButton(
                            color: Colors.white,
                            child: Text("Edit"),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                                  PostEdit(docId: doc.id, uid: widget.uid)));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            iconSize: 30,
                            onPressed: (){
                              deleteDialog(doc.id, doc['postTitle']);
                            },
                          )
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
    if(!widget.isHomePage){
      final CollectionReference myCollection = FirebaseFirestore.instance
      .collection('post');
      final Query myQuery = myCollection.where('postAuthorUid', isEqualTo: widget.otherUid);
      return Expanded(
        child: StreamBuilder(
          stream: myQuery.snapshots(),
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
                      onTap: () {
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => OtherProfile(uid: widget.uid, otherUid: doc["postAuthorUid"])),);
                      },
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
                                builder: (BuildContext context) => PostPage(uid: widget.uid, postID: doc.id, focusComment: false, user: username,)));
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
                                onPressed: () async {
                                  var control = false;
                                  await FirebaseFirestore.instance.collection('post').
                                  doc(doc.id).collection('liked').get().then((queryLike) =>
                                  {
                                        queryLike.docs.forEach((element) {
                                          if(element.id == widget.uid) {
                                            FirebaseFirestore.instance.collection('post').
                                            doc(doc.id).collection('liked').doc(widget.uid).delete();
                                            FirebaseFirestore.instance.collection('post').doc(doc.id)
                                                .update({'likes': doc['likes'] - 1});
                                            control = true;
                                          }
                                        })
                                  }
                                  );
                                  if(control == false) {
                                    FirebaseFirestore.instance.collection('post')
                                        .doc(doc.id).collection('liked').doc(widget.uid)
                                        .set({'isLiked': username});
                                    FirebaseFirestore.instance.collection('post').doc(doc.id)
                                        .update({'likes': doc['likes'] + 1});
                                  }
                                }
                              ),
                              Text(doc['likes'].toString()),
                              IconButton(
                                icon: Icon(Icons.comment),
                                iconSize: 30,
                                onPressed: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) => PostPage(uid: widget.uid, postID: doc.id, focusComment: true, user: username)));
                                },
                              ),
                            ],
                          ),
                          MaterialButton(
                            color: Colors.white,
                            child: Text("Like Details"),
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => WhoLiked(uid: widget.uid, docId: doc.id)));
                            },
                          )
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
                    onTap: () {
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => OtherProfile(uid: widget.uid, otherUid: doc["postAuthorUid"])),);
                    },
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
                              builder: (BuildContext context) => PostPage(uid: widget.uid, postID: doc.id, focusComment: false, user: username)));
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
                              onPressed: () async {
                                var control = false;
                                await FirebaseFirestore.instance.collection('post').
                                doc(doc.id).collection('liked').get().then((queryLike) =>
                                {
                                  queryLike.docs.forEach((element) {
                                    if(element.id == widget.uid) {
                                      FirebaseFirestore.instance.collection('post').
                                      doc(doc.id).collection('liked').doc(widget.uid).delete();
                                      FirebaseFirestore.instance.collection('post').doc(doc.id)
                                          .update({'likes': doc['likes'] - 1});
                                      control = true;
                                    }
                                  })
                                }
                                );
                                if(control == false) {
                                  FirebaseFirestore.instance.collection('post')
                                      .doc(doc.id).collection('liked').doc(widget.uid)
                                      .set({'isLiked': username});
                                  FirebaseFirestore.instance.collection('post').doc(doc.id)
                                      .update({'likes': doc['likes'] + 1});
                                }
                              },
                            ),
                            Text(doc['likes'].toString()),
                            IconButton(
                              icon: Icon(Icons.comment),
                              iconSize: 30,
                              onPressed: (){
                                Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => PostPage(uid: widget.uid, postID: doc.id, focusComment: true, user: username)));
                              },
                            ),
                          ],
                        ),
                        MaterialButton(
                          color: Colors.white,
                          child: Text("Like Details"),
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => WhoLiked(uid: widget.uid, docId: doc.id)));
                          },
                        )
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
