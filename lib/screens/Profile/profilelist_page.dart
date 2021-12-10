import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nallagram/screens/Profile/user_profile.dart';
import 'profile.dart';

import '../../nav.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
final currentUsermail = loggedInUser.email;

class ProfileList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: UsersStream(),
      ),
    );
  }
}

class UserBubble extends StatefulWidget {
  final String profileUrl;
  final String name;
  final int posts;
  final int followers;
  final int following;
  final String descr;
  final String selectedUser;
  final bool isMe;
  UserBubble(
      {@required this.profileUrl,
      @required this.descr,
      @required this.posts,
      @required this.followers,
      @required this.following,
      @required this.name,
      @required this.isMe,
      @required this.selectedUser});

  @override
  State<UserBubble> createState() => _UserBubbleState();
}

class _UserBubbleState extends State<UserBubble> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isMe) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MaterialApp(
                          home: Scaffold(
                              appBar: AppBar(
                                backgroundColor: Colors.white,
                                leading: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              body: UserProfile(
                                  followers: widget.followers,
                                  following: widget.following,
                                  posts: widget.posts,
                                  photoUrl: widget.profileUrl,
                                  descr: widget.descr,
                                  name: widget.name,
                                  userid: widget.selectedUser)))));
            });
          },
          child: Container(
            height: 70,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            radius: 32,
                            backgroundImage:
                                CachedNetworkImageProvider(widget.profileUrl)),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name == null ? '' : widget.name,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Metropolis'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text('Tap to view profile',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'Metropolis')),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: FaIcon(FontAwesomeIcons.comment),
                // ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class UsersStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('users').snapshots(),
      builder: (context, snapshot) {
        List<UserBubble> userBubbles = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ),
          );
        }
        final users = snapshot.data.docs;

        for (var user in users) {
          final profile = user['profile'];
          final name = user['name'];
          final followers = user['followers'];
          final following = user['following'];
          final descr = user['descr'];
          final posts = user['posts'];
          final selectedUid = user['userid'];
          final currentUser = loggedInUser.displayName;
          final userBubble = UserBubble(
            descr: descr,
            followers: followers,
            following: following,
            posts: posts,
            profileUrl: profile,
            selectedUser: selectedUid,
            name: name,
            isMe: currentUser == name,
          );
          userBubbles.add(userBubble);
        }
        return ListView(
          children: userBubbles,
        );
      },
    );
  }
}
