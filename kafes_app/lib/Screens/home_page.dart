import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafes_app/Components/post_flow.dart';
import 'package:kafes_app/Screens/new_post.dart';
import 'package:kafes_app/Screens/profile_page.dart';
import 'package:kafes_app/Screens/filter_page.dart';
import 'package:kafes_app/Components/categoryOptions.dart';

class HomePage extends StatefulWidget {
  HomePage({
    this.uid,
  });
  final String uid;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void filterDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Pick A Filter",
              style: TextStyle(color: Colors.redAccent),
            ),
            content: Column(
              children: <Widget>[
                ListTile(
                  leading: MaterialButton(
                    child: Text(
                      "Most Liked",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FilterPage(filter: "like", uid: widget.uid))),
                    },
                  ),
                ),
                ListTile(
                  leading: MaterialButton(
                    child: Text(
                      "Oldest Posts First",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => FilterPage(filter: "oldest", uid: widget.uid))),
                    },
                  ),
                ),
               CategoryOptions(uid: widget.uid),
              ],
            ),
            actions: [
              TextButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.profile_circled,
            color: Colors.white,
            size: 40.0,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ProfilePage(uid: widget.uid)));
          },
        ),
        title: Text(
          "Kafes",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(
                CupertinoIcons.search_circle,
                size: 40.0,
              ),
              onPressed: () {
                filterDialog();
              })
        ],
        backgroundColor: Colors.redAccent,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              snap: true,
              title: Text(
                'Latest Posts',
                style: TextStyle(color: Colors.redAccent),
              ),
              backgroundColor: Colors.white,
            )
          ];
        },
        body: Column(
          children: [
            PostFlow(
                uid: widget.uid,
                isHomePage: true,
                otherUid: widget.uid,
                editProfile: false),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => NewPost(uid: widget.uid)));
        },
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: Colors.redAccent,
        tooltip: "New Post",
      ),
    );
  }
}
