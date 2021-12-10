import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nallagram/models/story_view_model.dart';
// import 'package:nallagram/screens/create_page.dart';
// import 'package:nallagram/nav.dart';
// import 'package:nallagram/screens/profile.dart';
import 'package:nallagram/screens/Story/storyview.dart';
import 'package:like_button/like_button.dart';
import 'package:nallagram/widgets/story_widget.dart';
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
                      StoryWid(img:StoryViewData[0].img , name:StoryViewData[0].name),
                      spacing(),
                       StoryWid(img:StoryViewData[1].img, name:StoryViewData[1].name),
                      spacing(),
                       StoryWid(img:StoryViewData[2].img, name:StoryViewData[2].name),
                      spacing(),
                       StoryWid(img:StoryViewData[3].img, name:StoryViewData[3].name),
                      spacing(),
                      StoryWid(img:StoryViewData[4].img, name:StoryViewData[4].name),
                      spacing(),
                       StoryWid(img:StoryViewData[5].img, name:StoryViewData[5].name),
                      spacing(),
                       StoryWid(img:StoryViewData[6].img, name:StoryViewData[6].name),
                      spacing(),
                       StoryWid(img:StoryViewData[7].img, name:StoryViewData[7].name),
                      spacing(),
                      StoryWid(img:StoryViewData[8].img, name:StoryViewData[8].name),
                      spacing(),
                       StoryWid(img:StoryViewData[9].img, name:StoryViewData[9].name),
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

class PostCard extends StatefulWidget {
  bool isLiked = false;
  int likes;

  final String name;
  final String place;
  final String profilePic;
  final String postUrl;
  final String postID;

  PostCard(
      {@required this.likes,
      @required this.name,
      // @required this.liked,
      @required this.place,
      @required this.profilePic,
      @required this.postUrl,
      @required this.postID});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _commentButtomPressed() {
      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CommentsPage(
                      postID: widget.postID,
                    )));
      });
    }

    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            shadowColor: Colors.black,
            elevation: 40.0,
            child: Container(
              height: 450,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                // image: DecorationImage(
                //     image: NetworkImage(widget.postUrl), fit: BoxFit.cover),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                child: CachedNetworkImage(
                  imageUrl: widget.postUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 450,
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                    color: Colors.red.shade100,
                  )),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            setState(() {
              widget.isLiked = !widget.isLiked;
              if (widget.isLiked) {
                widget.likes += 1;
              } else if (widget.likes > 0) {
                widget.likes -= 1;
              }

              // widget.likes += 1;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            child: Container(
              height: 450.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.white,
                  gradient: LinearGradient(
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                    colors: [
                      Colors.grey.withOpacity(0.0),
                      Colors.black.withOpacity(0.5),
                    ],
                  )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.red.shade100,
              backgroundImage: CachedNetworkImageProvider(widget.profilePic),
            ),
            title: Text(
              widget.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Metropolis',
                fontSize: 14.0,
              ),
            ),
            subtitle: Text(
              widget.place,
              style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Metropolis',
                  color: Colors.white),
            ),
            dense: true,
            trailing: Icon(
              Icons.more_vert,
              color: Colors.white.withOpacity(0.8),
              // size: 15,
            ),
          ),
        ),
        // Positioned.fill(
        //   top: 340,
        //   child: Align(
        //     alignment: Alignment.center,
        //     child: Center(
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.all(Radius.circular(32)),
        //         child: BackdropFilter(
        //           filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        //           child: Container(
        //             width: 200,
        //             height: 50,
        //             decoration: BoxDecoration(
        //               color: Colors.white10.withOpacity(0.5),
        //               borderRadius: BorderRadius.all(Radius.circular(50.0)),
        //             ),
        Positioned.fill(
          top: 350,
          left: 25,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.isLiked = !widget.isLiked;
                                if (widget.isLiked) {
                                  widget.likes += 1;
                                } else if (widget.likes > 0) {
                                  widget.likes -= 1;
                                }
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(
                                milliseconds: 400,
                              ),
                              decoration: BoxDecoration(
                                color: !widget.isLiked
                                    ? Colors.grey.withOpacity(0.5)
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.solidHeart,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        '${widget.likes}',
                                        style: TextStyle(
                                          fontFamily: 'Metropolis',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: IconButton(
                          onPressed: () => _commentButtomPressed(),
                          icon: FaIcon(
                            FontAwesomeIcons.solidCommentDots,
                            size: 20,
                          ),
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 20.0),
                  child: LikeButton(
                    likeBuilder: (bool isLiked) {
                      return FaIcon(
                        FontAwesomeIcons.bookmark,
                        color: Colors.white,
                        size: 20,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
