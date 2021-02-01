import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kafes_app/Screens/home_page.dart';



class NewPost extends StatefulWidget {

  NewPost({this.uid});
  final String uid;


  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {

  final _formKey = GlobalKey<FormState>();
  var postTitle = '';
  var postBody = '';
  var postDate = DateTime.now();
  String postTopic = 'General';
  var postAuthorUsername = '';
  String postID = '' ;



  void submitPost() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      FirebaseFirestore.instance.collection('post').doc().set(
          {'postTitle': postTitle,
            'postBody': postBody,
            'postTopic' : postTopic,
            'postDate': postDate,
            'postAuthorUsername' : postAuthorUsername,
            'postAuthorUid': widget.uid}).whenComplete(() =>
              Navigator.push(context,
                  MaterialPageRoute(
                   builder: (BuildContext context) => HomePage(uid: widget.uid))));

    }
  }

  @override
  void initState() {
    getPostAuthorUsername();
  }

  void getPostAuthorUsername() async {
    final userData = await FirebaseFirestore.instance.collection('user').doc(widget.uid).get();
    setState(() {
      postAuthorUsername = userData.get('username');
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("New Post"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0,),
                child: TextFormField(
                  style: TextStyle(color: Colors.red),
                  key: ValueKey('postTitle'),
                  validator: (value) {
                    if(value.isEmpty || value.length < 6 ) {
                      return 'Post Title length must be at least 6';
                    }
                    return null;
                  },
                  onSaved: (value){
                    postTitle = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter Post Title'
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0,),
                child: TextFormField(
                  maxLines: 10,
                  style: TextStyle(color: Colors.red),
                  key: ValueKey('postBody'),
                  validator: (value) {
                    if(value.isEmpty || value.length < 6 ) {
                      return 'Post Body length must be at least 6';
                    }
                    return null;
                  },
                  onSaved: (value){
                    postBody = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter Post Body'
                  ),
                ),
              ),
              Container (
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: DropdownButton<String>(
                    hint: Text("Choose Topic"),
                    isExpanded: true,
                    value: postTopic,
                    elevation: 15,
                    style: TextStyle(color: Colors.redAccent),
                    underline: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    onChanged: (String newValue){
                      setState(() {
                        postTopic = newValue;
                      });
                    },
                    items: ["General","Computer Engineering","Software Engineering","Aerospace Engineering",
                      "Biomedical Engineering","Civil Engineering", "Electrical and Electronics Engineering",
                      "Food Engineering", "Genetics and Bioengineering", "Industrial Engineering",
                      "Mechanical Engineering", "Mechatronics Engineering", "Mathematics", "Physics",
                      "English Translation and Interpreting", "Psychology", "Sociology", "Architecture",
                      "Industrial Design", "Interior Architecture and Environmental Design", "Textile and Fashion Design",
                      "Visual Communication Design", "Law", "Cinema and Digital Media", "New Media and Communication",
                      "Public Relations and Advertising", "Accounting and Auditing Program", "Business Administration",
                      "Economics", "International Trade and Finance", "Logistics Management", "Health Management", "Nursing",
                      "Medicine",]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        submitPost();
      },
        child: Icon(Icons.add, color: Colors.redAccent,),
        backgroundColor: Colors.white,
        tooltip: "Post It",
      ),
    );
  }
}
