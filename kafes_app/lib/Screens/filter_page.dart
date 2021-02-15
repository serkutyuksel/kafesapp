import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafes_app/Screens/other_profile.dart';
import 'package:kafes_app/Screens/post_page.dart';
import 'package:kafes_app/Screens/who_liked.dart';




class FilterPage extends StatefulWidget {
  FilterPage({this.filter, this.uid});
  final filter;
  final uid;

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  var username;

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
    if (widget.filter == "like"){
      final CollectionReference myCollection = FirebaseFirestore.instance
          .collection('post');
      final Query myQuery = myCollection.orderBy("likes", descending: true);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text( "Most Liked Posts",
            style: TextStyle(fontSize: 20, fontFamily: "BebasNeue"),
          ),
        ),
        body: SafeArea(
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
        ),
      );
    }
    else if (widget.filter == "oldest") {
      final CollectionReference myCollection = FirebaseFirestore.instance
          .collection('post');
      final Query myQuery = myCollection.orderBy("postDate", descending: false);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text( "Oldest Posts",
            style: TextStyle(fontSize: 20, fontFamily: "BebasNeue"),
          ),
        ),
        body: SafeArea(
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
        ),
      );

    }
    else {
        final CollectionReference myCollection = FirebaseFirestore.instance
            .collection('post');
        final Query myQuery = myCollection.where('postTopic', isEqualTo: widget.filter);
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.redAccent,
              title: Text( widget.filter,
                style: TextStyle(fontSize: 20, fontFamily: "BebasNeue"),
              ),
            ),
            body: SafeArea(
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
            ),
        );
    }

  }
}
