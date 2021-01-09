import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafes_app/Components/post_flow.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(CupertinoIcons.profile_circled, color: Colors.white, size: 40.0,),
        onPressed: (){
          Navigator.of(context).pushNamed('/profile');
        },),
        title: Text("Kafes", style: TextStyle(color: Colors.white),),
        actions: [
          Icon(
            CupertinoIcons.search_circle,
            color: Colors.white,
            size: 30.0,
          ),
        ],
        backgroundColor: Colors.redAccent,
      ),
      body: NestedScrollView(

          headerSliverBuilder: (BuildContext context, innerBoxIsScrolled){
            return[
              SliverAppBar(
                floating: true,
                snap: true,
                title: Text('Latest Posts', style: TextStyle(color: Colors.redAccent),),
                backgroundColor: Colors.white,
              )
            ];
          },
          body: Column(
        children: [
          PostFlow(),
        ],
      ),),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).pushNamed('/add_post');
      },
      child: Icon(Icons.edit, color: Colors.white,),
        backgroundColor: Colors.redAccent,
          tooltip: "New Post",
      ),
    );
  }
}
