import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nallagram/models/story_view_model.dart';
// import 'package:nallagram/screens/create_page.dart';
// import 'package:nallagram/nav.dart';
// import 'package:nallagram/screens/profile.dart';
import 'package:like_button/like_button.dart';
import 'package:nallagram/widgets/story_widget.dart';
import '../../widgets/post_card.dart';
import '../Comments/commentspage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import '../data.dart';

final _firestore = FirebaseFirestore.instance;

List<String> likedusers = [];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SizedBox spacing() {
    return SizedBox(
      width: 15.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      spacing(),
                      StoryWid(
                          img: StoryViewData[0].img,
                          name: StoryViewData[0].name),
                      spacing(),
                      StoryWid(
                          img: StoryViewData[1].img,
                          name: StoryViewData[1].name),
                      spacing(),
                      StoryWid(
                          img: StoryViewData[2].img,
                          name: StoryViewData[2].name),
                      spacing(),
                      StoryWid(
                          img: StoryViewData[3].img,
                          name: StoryViewData[3].name),
                      spacing(),
                      StoryWid(
                          img: StoryViewData[4].img,
                          name: StoryViewData[4].name),
                      spacing(),
                      StoryWid(
                          img: StoryViewData[5].img,
                          name: StoryViewData[5].name),
                      spacing(),
                      StoryWid(
                          img: StoryViewData[6].img,
                          name: StoryViewData[6].name),
                      spacing(),
                      StoryWid(
                          img: StoryViewData[7].img,
                          name: StoryViewData[7].name),
                      spacing(),
                      StoryWid(
                          img: StoryViewData[8].img,
                          name: StoryViewData[8].name),
                      spacing(),
                      StoryWid(
                          img: StoryViewData[9].img,
                          name: StoryViewData[9].name),
                      spacing(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          PostStream(),
        ],
      ),
    ]);
  }
}

class PostStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('posts').orderBy('timestamp').snapshots(),
      builder: (context, snapshot) {
        List<PostCard> postCards = [];
        Future Likecheck(postid) async {
          var data = await _firestore
              .collection('posts')
              .doc(postid)
              .collection('liked')
              .get();
          return snapshot.data;
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ),
          );
        }
        final posts = snapshot.data.docs;

        for (var post in posts) {
          // var likedusrs = await Likecheck(post.id);
          // var data = likedusrs.data();
          final likesCount = post['likes'];
          final name = post['name'];
          final place = post['place'];
          final profilePic = post['profilepicurl'];
          final postUrl = post['url'];
          final postId = post.id;
          final postCard = PostCard(
            likes: likesCount,
            // liked: ,
            name: name,
            place: place,
            profilePic: profilePic,
            postUrl: postUrl,
            postID: postId,
          );
          postCards.add(postCard);
        }
        return ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: postCards.reversed.toList(),
        );
      },
    );
  }
}
