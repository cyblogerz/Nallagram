import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:nallagram/screens/create_page.dart';
// import 'package:nallagram/nav.dart';
// import 'package:nallagram/screens/profile.dart';
import 'package:nallagram/screens/storyview.dart';
import 'package:like_button/like_button.dart';
import 'commentspage.dart';
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

  List<String> _names = [
    'ibram',
    'moien',
    'arunsmoki',
    'ralraj',
    'kimbean',
    'tkstark',
    'peter',
    'desuza',
    'akvlogger',
    'karthiks',
    'dravid',
    'juan',
    'kannan'
  ];

  @override
  Widget build(BuildContext context) {
    Widget BuildKey(int num, String name) {
      return Container(
        child: Column(children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StoryPageView()));
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 7),
                  ),
                ],
                gradient: LinearGradient(
                  colors: [Color(0xFF9B2282), Color(0xFFEEA863)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage('images/usr$num.jfif'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            // padding: const EdgeInsets.fromLTRB(10.0, 5.0, 8.0, 5.0),
            padding: EdgeInsets.all(8.0),
            child: Text(
              '$name',
              style: TextStyle(
                fontFamily: 'Metropolis',
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ]),
      );
    }

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
                      BuildKey(1, _names[0]),
                      spacing(),
                      BuildKey(2, _names[1]),
                      spacing(),
                      BuildKey(3, _names[2]),
                      spacing(),
                      BuildKey(4, _names[3]),
                      spacing(),
                      BuildKey(5, _names[4]),
                      spacing(),
                      BuildKey(6, 'kimbean'),
                      spacing(),
                      BuildKey(7, _names[5]),
                      spacing(),
                      BuildKey(8, _names[6]),
                      spacing(),
                      BuildKey(9, _names[7]),
                      spacing(),
                      BuildKey(10, _names[8]),
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
  // Future likedUsers(loggedInuser) async {
  //   var docref = await _firestore.collection('posts').doc(widget.postID).get();
  //   var data = docref.data();
  //   likedusers = data['likedusers'];
  // }

  @override
  void initState() {
    // likedUsers(loggedInUser);
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

    // void liked() {
    //   List likedlist = [];
    //   isPostLiked
    //       ? likedlist.add(loggedInUser.uid.toString())
    //       : likedlist.remove(loggedInUser.uid.toString());
    //   _firestore.collection('posts').doc(widget.postID).update({
    //     'likedusers': likedlist,
    //   });

    //   print('double tapped');
    // }

    // void likeCheck() async {
    //   Future<DocumentSnapshot> docSnapshot =
    //       _firestore.collection('posts').doc(widget.postID).get();
    //   DocumentSnapshot doc = await docSnapshot;
    //   if (doc['likedusers'].contains(loggedInUser.uid)) {
    //     isPostLiked = true;
    //   } else {
    //     isPostLiked = false;
    //   }
    // }

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
