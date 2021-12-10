import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nallagram/screens/Chat/chat_model.dart';
// import 'package:nallagram/edit_profile.dart';
import 'package:nallagram/screens/Posts/postView_model.dart';
import 'package:nallagram/screens/Story/storyview.dart';

//Profile photo - squircle --> posts no | Followers no | Following no |
//Name o <em>Position</em>
//About
final _auth = FirebaseAuth.instance;
final _store = FirebaseFirestore.instance;
List<dynamic> followinglist = [];
int cufollowing;
bool _persposts = true;
int followers;
List<dynamic> followlist = [];

void getCurrentUser() {
  try {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
      print(loggedInUser);
    }
  } catch (e) {
    print(e);
  }
}

void followData(userId) async {
  var userDat = await _store.collection('users').doc(userId).get();
  var currentDat =
      await _store.collection('users').doc(loggedInUser.uid.toString()).get();
  followinglist = currentDat['followinglist'];
  cufollowing = currentDat['following'];
  var data = userDat.data();
  followlist = data['followerlist'];
  followers = data['followers'];
}

// User loggedInUser;
// var data;
// int posts;
// // String userId;
// var descr;
// int followers;
// int following;

class UserProfile extends StatefulWidget {
  final posts;
  final descr;
  final photoUrl;
  final name;
  final userid;
  String followState = 'Follow';
  int followers;
  int following;

  UserProfile(
      {@required this.posts,
      @required this.photoUrl,
      @required this.descr,
      @required this.name,
      @required this.followers,
      @required this.following,
      @required this.userid});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    followData(widget.userid);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0, bottom: 10.0),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(widget.photoUrl),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      '${widget.posts}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Metropolis'),
                    ),
                  ),
                  Text(
                    'Posts',
                    style: TextStyle(fontFamily: 'Metropolis', fontSize: 12),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: FaIcon(
                  FontAwesomeIcons.ellipsisV,
                  size: 10,
                  color: Colors.grey,
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      '${widget.followers}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Metropolis'),
                    ),
                  ),
                  Text(
                    'Followers',
                    style: TextStyle(fontFamily: 'Metropolis', fontSize: 12),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: FaIcon(
                  FontAwesomeIcons.ellipsisV,
                  size: 10,
                  color: Colors.grey,
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      '${widget.following}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Metropolis'),
                    ),
                  ),
                  Text(
                    'Following',
                    style: TextStyle(fontFamily: 'Metropolis', fontSize: 12),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.name.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Metropolis',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
                // constraints: BoxConstraints(maxWidth: ),
                child: Text('${widget.descr}')),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        followlist.contains(loggedInUser.uid)
                            ? Colors.white
                            : Colors.blue,
                      ),
                    ),
                    onPressed: () async {
                      if (!followlist.contains(loggedInUser.uid.toString())) {
                        setState(() {
                          // widget.followState = 'Unfollow';
                          followers += 1;
                          widget.followers = followers;
                          followlist.add(loggedInUser.uid.toString());
                          cufollowing += 1;
                        });
                      } else {
                        setState(() {
                          // widget.followState = 'Follow';
                          followers -= 1;
                          widget.followers = followers;
                          followlist.remove(loggedInUser.uid.toString());
                          cufollowing -= 1;
                        });
                      }
                      _store
                          .collection('users')
                          .doc(widget.userid)
                          .update({'followers': followers});

                      _store
                          .collection('users')
                          .doc(widget.userid)
                          .update({'followerlist': followlist});

                      _store.collection('users').doc(loggedInUser.uid).update({
                        'followinglist': followlist,
                      });
                      _store
                          .collection('users')
                          .doc(loggedInUser.uid.toString())
                          .update({'following': cufollowing});
                    },
                    child: Text(
                      followlist.contains(loggedInUser.uid.toString())
                          ? 'Unfollow'
                          : 'Follow',
                      style: TextStyle(
                          color:
                              followlist.contains(loggedInUser.uid.toString())
                                  ? Colors.black
                                  : Colors.white),
                    )),
              )),
              SizedBox(width: 10),
              Expanded(
                  child: Container(
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PmScreen(selectedUser: widget.userid);
                      }));
                    },
                    child: Text(
                      'Message',
                      style: TextStyle(color: Colors.black),
                    )),
              )),
            ],
          ),
          // Row(
          //   children: <Widget>[
          //     Container(
          //       height: 100,
          //       width: 100,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20),
          //         border: Border()
          //       ),
          //       child: Icon(Icons.add),
          //     ),
          //   ],
          // ),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: <Widget>[
          //       Highlight(
          //           name: 'Github',
          //           url:
          //               'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png'),
          //       Highlight(
          //           name: 'LinkedIn',
          //           url:
          //               'https://cdn2.iconfinder.com/data/icons/simple-social-media-shadow/512/14-512.png'),
          //       Highlight(
          //           name: 'LinkedIn',
          //           url:
          //               'https://cdn2.iconfinder.com/data/icons/simple-social-media-shadow/512/14-512.png'),
          //       Highlight(
          //           name: 'LinkedIn',
          //           url:
          //               'https://cdn2.iconfinder.com/data/icons/simple-social-media-shadow/512/14-512.png'),
          //       Highlight(
          //           name: 'LinkedIn',
          //           url:
          //               'https://cdn2.iconfinder.com/data/icons/simple-social-media-shadow/512/14-512.png'),
          //     ],
          //   ),
          // ),
          ProfilePosts(
            userid: widget.userid,
          ),
        ],
      ),
    );
  }
}

class Highlights extends StatefulWidget {
  final String name;
  final String url;

  Highlights({@required this.name, @required this.url});

  @override
  _HighlightsState createState() => _HighlightsState();
}

class _HighlightsState extends State<Highlights> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Column(children: <Widget>[]),
    );
  }
}

class ProfilePosts extends StatefulWidget {
  final userid;

  ProfilePosts({@required this.userid});
  @override
  _ProfilePostsState createState() => _ProfilePostsState();
}

class _ProfilePostsState extends State<ProfilePosts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 500,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Material(
                    type: MaterialType
                        .transparency, //Makes it usable on any background color, thanks @IanSmith
                    child: Ink(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: _persposts ? Colors.black : Colors.grey,
                                width: 0.5)),
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                      ),
                      child: InkWell(
                        //This keeps the splash effect within the circle
                        borderRadius: BorderRadius.circular(
                            1000), //Something large to ensure a circle
                        onTap: () {
                          setState(() {
                            _persposts = true;
                          });
                        },
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: FaIcon(
                              FontAwesomeIcons.thLarge,
                              color: _persposts ? Colors.black : Colors.grey,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
              Expanded(
                child: Material(
                  type: MaterialType
                      .transparency, //Makes it usable on any background color, thanks @IanSmith
                  child: Ink(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: _persposts ? Colors.grey : Colors.black,
                                width: 0.5)),
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                      ),
                      child: InkWell(
                        //This keeps the splash effect within the circle
                        borderRadius: BorderRadius.circular(
                            1000.0), //Something large to ensure a circle
                        onTap: () {
                          setState(() {
                            _persposts = false;
                          });
                        },
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: FaIcon(
                              FontAwesomeIcons.userTag,
                              size: 15,
                              color: _persposts ? Colors.grey : Colors.black,
                            ),
                          ),
                        ),
                      )),
                  // child: IonButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         _persposts = false;
                  //       });
                  //     },
                  //     icon: FaIcon(
                  //       FontAwesomeIcons.solidIdBadge,
                  //     )),
                ),
              ),
            ],
          ),
          _persposts
              ? ProfilePostsStream(userid: widget.userid)
              : Expanded(child: Tagged()),
        ],
      ),
    );
  }
}

class ImagePost extends StatelessWidget {
  final String url;
  final bool isMe = true;
  ImagePost({@required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => POstView(url)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.red.shade100,
          image: DecorationImage(
              image: CachedNetworkImageProvider(url), fit: BoxFit.cover),
        ),
      ),
    );

    // else {
    //     return Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.only(bottom: 5.0),
    //             child: Text(
    //               sender,
    //               style: TextStyle(color: Colors.black54, fontSize: 12),
    //             ),
    //           ),
    //           Container(
    //             // elevation: 5.0,
    //             decoration: BoxDecoration(
    //               gradient: LinearGradient(
    //                 colors: [Colors.pink, Colors.redAccent, Colors.orange],
    //                 begin: Alignment.bottomRight,
    //                 end: Alignment.topLeft,
    //               ),
    //               borderRadius: BorderRadius.only(
    //                   bottomLeft: Radius.circular(30.0),
    //                   topRight: Radius.circular(30.0),
    //                   bottomRight: Radius.circular(30.0)),
    //             ),

    //             child: Padding(
    //               padding: const EdgeInsets.symmetric(
    //                   vertical: 10.0, horizontal: 20.0),
    //               child: Text(
    //                 text == null ? '' : text,
    //                 style: TextStyle(
    //                   fontSize: 16,
    //                   color: Colors.white,
    //                   fontFamily: 'Metropolis',
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   }
  }
}

class ProfilePostsStream extends StatelessWidget {
  final userid;

  ProfilePostsStream({@required this.userid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _store
          .collection('users')
          .doc(userid)
          .collection('posts')
          .snapshots(),
      builder: (context, snapshot) {
        List<ImagePost> ImagePosts = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ),
          );
        }
        final posts = snapshot.data.docs.reversed;

        for (var post in posts) {
          if (post['userid'] == userid) {
            final image = post['url'];
            final imagePost = ImagePost(
              url: image,
            );
            ImagePosts.add(imagePost);
          }
        }
        return Expanded(
          child: ImagePosts.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'No photos yet',
                      style: TextStyle(fontFamily: 'Metropolis'),
                    )
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: GridView.count(
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    crossAxisCount: 3,
                    children: ImagePosts,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                ),
        );
      },
    );
  }
}

class Tagged extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'No photos yet',
          style: TextStyle(fontFamily: 'Metropolis'),
        )
      ],
    );
  }
}

class Highlight extends StatefulWidget {
  final String name;
  final String url;

  Highlight({this.name, this.url});

  @override
  _HighlightState createState() => _HighlightState();
}

class _HighlightState extends State<Highlight> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.pink.withOpacity(0.2),
                //     spreadRadius: 2,
                //     blurRadius: 8,
                //     offset: Offset(0, 7),
                //   ),
                // ],
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blue],
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
                            image: NetworkImage(widget.url), fit: BoxFit.cover),
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
              widget.name,
              style: TextStyle(
                fontFamily: 'Metropolis',
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
