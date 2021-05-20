import 'package:flutter/material.dart';
import 'dart:math';

import 'package:like_button/like_button.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key key}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}
List <String> _comments = ['enik ii post ishtapettu ','Well,Hello there','Adios Amigos','hola','@peter ayinu'];
List <int> _pics = [1,2,3,4,5,6,7,8,9,10];
List <String> _names = ['ibrahim_kutty','moid_een','arunsmoki','rahulraj_2020','kimbean','tony_stark','peter_parker','amelia_desuza','akshayvlogger','karthiksur_ya','rasput_david','juan','kan_nan'];


class _CommentsPageState extends State<CommentsPage> {
  void _addcomment(String val){
setState(() {
  _comments.add(val);
});
}

Widget _buildCommentList() {
  return ListView.builder(
      itemBuilder: (context, index) {
        if (index < _comments.length) {
          return _buildCommentItem(_comments[index],_pics[Random().nextInt(10)],_names[Random().nextInt(3)]);
        }
      }
  );
}

Widget _buildCommentItem( String comment,int pnum,String name){
    return ListTile(
      leading: CircleAvatar(
        radius: 20.0,
        backgroundImage: AssetImage('images/usr$pnum.jfif'),
      ),
      title: Text(name),
    subtitle: Text(comment),
      trailing: Icon(
        Icons.favorite_border,
        color: Colors.red,
        size: 20.0,
      )


    );
}
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text('Comments',
        style: TextStyle(
          color: Colors.black
        ),),
        backgroundColor: Colors.white,
      ),
      body: Column(children: <Widget>[
        Expanded(child: _buildCommentList()),
      TextField(
        onSubmitted: (String  submittedStr){
          _addcomment(submittedStr);

        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
            contentPadding: const EdgeInsets.all(20.0),
          hintText: 'Add a comment',

        ),
      ),
  ]
      )
    );
  }
}
