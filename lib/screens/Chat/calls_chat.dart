import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nallagram/screens/Chat/calls_model.dart';
import 'package:nallagram/screens/Chat/chat_model.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User _loggedInUser;
List<String> docList = [];
void docCheck() async {
  var result = await _firestore
      .collection('users')
      .doc(_loggedInUser.uid)
      .collection('messages')
      .get();
  result.docs.forEach((res) {
    docList.add(res.id.toString());
  });
}

class CallsChat extends StatefulWidget {
  static const String id = 'calls_chat';
  @override
  _CallsChatState createState() => _CallsChatState();
}

class _CallsChatState extends State<CallsChat> {
  //initialising firestore

  String messageText;

  @override
  void initState() {
    super.initState();
    // docCheck();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        _loggedInUser = user;
        print(_loggedInUser);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(CupertinoIcons.back),
          color: Colors.black,
        ),
        elevation: 0,
        title: Text(
          'Calls',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CallsModel(
              icon: CupertinoIcons.phone,
              type: 'Audio',
              typeDescription: 'Start with audio',
            ),
            CallsModel(
              icon: CupertinoIcons.video_camera,
              type: 'Video',
              typeDescription: 'Hang out on video',
            ),
            UsersStream(),
          ],
        ),
      ),
    );
  }
}

class UserBubble extends StatefulWidget {
  final String profileUrl;
  final String name;
  final String time;
  final String message;
  final String selectedUser;
  final bool isMe;
  UserBubble(
      {@required this.profileUrl,
      @required this.name,
      @required this.message,
      @required this.time,
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
                      builder: (context) => PmScreen(
                            profileUrl: widget.profileUrl,
                            name: widget.name,
                            selectedUser: widget.selectedUser,
                          )));
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
                              CachedNetworkImageProvider(widget.profileUrl),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            left: 20.0,
                            bottom: 10,
                          ),
                          child: Text(
                            widget.name == null ? '' : widget.name,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Metropolis',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  //child: FaIcon(FontAwesomeIcons.comment),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.phone,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.videocam,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
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
          final selectedUid = user['userid'];
          final currentUser = _loggedInUser.displayName;
          final userBubble = UserBubble(
            profileUrl: profile,
            selectedUser: selectedUid,
            name: name,
            isMe: currentUser == name,
          );
          userBubbles.add(userBubble);
        }
        return Expanded(
          child: ListView(
            children: userBubbles,
          ),
        );
      },
    );
  }
}
