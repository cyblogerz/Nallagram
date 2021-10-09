import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Profile photo - squircle --> posts no | Followers no | Following no |
//Name o <em>Position</em>
//About
final _auth = FirebaseAuth.instance;
final _store = FirebaseFirestore.instance;
User currentUser;
Future data = _store.collection('users').doc(currentUser.uid).get();

class ProfileModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  image: DecorationImage(
                    image: NetworkImage(''),
                    fit: BoxFit.cover,
                  )),
            ),
            Column(
              children: <Widget>[Text('21'), Text('Posts')],
            ),
            FaIcon(
              FontAwesomeIcons.ellipsisV,
            ),
            Column(
              children: <Widget>[Text('21'), Text('Followers')],
            ),
            FaIcon(
              FontAwesomeIcons.ellipsisV,
            ),
            Column(
              children: <Widget>[Text('21'), Text('Following')],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(currentUser.displayName),
            FaIcon(FontAwesomeIcons.circle),
            Text('Flutter app developer'),
          ],
        ),
        Row(
          children: <Widget>[
            ElevatedButton(onPressed: () {}, child: Text('Follow')),
            ElevatedButton(onPressed: () {}, child: Text('Message'))
          ],
        ),
      ],
    );
  }
}
