import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nallagram/storyview.dart';
import 'package:like_button/like_button.dart';
import 'comentspage.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'data.dart';
import 'package:story_designer/story_designer.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  @override
  int _selectedIndex = 0;
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions = [
    Home(),
    Explore(),
    Create(),
    Activity(),
    Profile()
  ];

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'Nallagram',
          style: TextStyle(
            fontFamily: 'Billabong',
            color: Colors.black,
            fontSize: 35.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.paperPlane,
              color: Colors.black,
            ),
            onPressed: () {
              Toast.show("This feature is not yet available!", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey.shade200,
        buttonBackgroundColor: Colors.redAccent.shade100,
        height: 50.0,
        color: Colors.white,
        items: <Widget>[
          Icon(
            Icons.home,
            color: Colors.black,
            size: 25,
          ),
          Icon(
            Icons.search,
            color: Colors.black,
            size: 25.0,
          ),
          Icon(
            Icons.create_outlined,
            color: Colors.black,
            size: 25.0,
          ),
          FaIcon(
            FontAwesomeIcons.heart,
            size: 25.0,
          ),
          Icon(
            Icons.person_outline,
            color: Colors.black,
            size: 25.0,
          ),

          // BottomNavigationBarItem(icon: ),
          // label: 'Explore',
          // BottomNavigationBarItem(icon:
          // label: 'Create'),
          // BottomNavigationBarItem(icon:
          // label: 'Activity'),
          // BottomNavigationBarItem(icon:
          // label: 'Profile'),
        ],
        index: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _commentButtomPressed() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CommentsPage()));
    });
  }

  SizedBox spacing() {
    return SizedBox(
      width: 10.0,
    );
  }

  Container posts(
      int like, int pnum, String location, String name, String place) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            shadowColor: Colors.black,
            elevation: 40.0,
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 20.0,
                      backgroundImage: AssetImage('images/usr$pnum.jfif'),
                    ),
                    title: Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Metropolis',
                        fontSize: 15.0,
                      ),
                    ),
                    subtitle: Text(
                      place,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Metropolis'
                      ),
                    ),
                    dense: true,
                    trailing: Icon(
                      Icons.more_horiz,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                      image: DecorationImage(
                          image: AssetImage(
                            location,
                          ),
                          fit: BoxFit.cover),
                    ),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(75.0, 310.0, 75.0, 30.0),
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(0, 7),
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          LikeButton(
                              padding: EdgeInsets.only(
                                left: 8.0,
                                right: 15.0,
                              ),
                              size: 30.0,
                              likeCount: like,
                              countBuilder:
                                  (int count, bool isLiked, String text) {
                                var color =
                                    isLiked ? Colors.redAccent : Colors.black;
                                Widget result;
                                if (count == 0) {
                                  result = Text(
                                    "love",
                                    style: TextStyle(color: color),
                                  );
                                } else
                                  result = Text(
                                    text,
                                    style: TextStyle(
                                        color: color,
                                        fontWeight: FontWeight.bold,
                                    fontFamily: 'Metropolis'),
                                  );
                                return result;
                              },
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  Icons.favorite_border,
                                  color: isLiked ? Colors.red : Colors.black,
                                  size: 30.0,
                                );
                              }),
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                child: FaIcon(
                                  FontAwesomeIcons.commentDots,
                                  size: 30.0,
                                ),
                                onTap: () {
                                  _commentButtomPressed();
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  '10',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Metropolis',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          LikeButton(
                            padding: EdgeInsets.only(left: 10.0, right: 8.0),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                Icons.bookmark_border_rounded,
                                color:
                                    isLiked ? Colors.blueAccent : Colors.black,
                                size: 30.0,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ClipRRect(
                  //   borderRadius:BorderRadius.circular(20.0),
                  //   child: Image.network(
                  //     url,
                  //     width: double.infinity,
                  //     fit: BoxFit.fitWidth,
                  //
                  //   ),
                  // ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  //     //like,comment,share , bookmark
                  //
                  //     Row(
                  //       children: <Widget>[
                  //         LikeButton(
                  //           likeCount: like,
                  //         ),
                  //
                  //         IconButton(
                  //           icon: FaIcon(FontAwesomeIcons.comment),
                  //           onPressed: () {
                  //             _commentButtomPressed();
                  //           },
                  //         ),
                  //         // SizedBox(
                  //         //   width: 5.0,
                  //         // ),
                  //         Text(
                  //           '$comments ',
                  //           style: TextStyle(
                  //             fontSize: 15.0,
                  //             color: Colors.grey,
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //     IconButton(
                  //       icon: Icon(
                  //         Icons.bookmark_border,
                  //         size: 30.0,
                  //       ),
                  //       onPressed: () {
                  //         Toast.show("Bookmark added!", context,
                  //             duration: Toast.LENGTH_SHORT,
                  //             gravity: Toast.BOTTOM);
                  //       },
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }

  List<String> _names = [
    'ibrahim_kutty',
    'moid_een',
    'arunsmoki',
    'rahulraj_2020',
    'kimbean',
    'tony_stark',
    'peter_parker',
    'amelia_desuza',
    'akshayvlogger',
    'karthiksur_ya',
    'rasput_david',
    'juan',
    'kan_nan'
  ];
  List<String> _places = [
    'Kottayam',
    'Enathu',
    'Adoor',
    'Pathanamthitta',
    'OceanView',
    'Miami',
    'Newzealand',
    'Niagara',
    'Kerala',
    'Mumbai',
    'Paradise',
    'Pandalam',
    'Eranakulam',
    'Bhopal',
    'Kanyakumari'
  ];
  List<String> _pics = [
    'images/post1.gif',
    'images/daft punk.jfif',
    'images/gradlamp.jfif',
    'images/post3.gif',
    'images/Desk photo.jfif',
    'images/xplore1.gif',
    'images/techphoto.jfif',
    'images/usr1.jfif',
    'images/dogcoin.jfif',
    'images/vrphoto.jfif',
    'images/post2.gif',
    'images/iphone.jfif',
    'images/macbookpurp.jfif',
    'images/lbridge.jfif',
    'images/ipod.jfif',
    'images/Lambo.jfif',
    'images/post1.jpg',
    'images/post2.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    Column BuildKey(int num, String name) {
      return Column(children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => StoryPageView()));
          },
          child: Container(
            decoration: BoxDecoration(
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
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: CircleAvatar(
                radius: 36.0,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 32.0,
                  backgroundImage: AssetImage('images/usr$num.jfif'),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 8.0, 5.0),
          child: Text(
            '$name',
            style: TextStyle(
              fontFamily: 'Metropolis',
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ]);
    }

    return ListView(
      children: [
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
                        BuildKey(1, gen(_names)),
                        spacing(),
                        BuildKey(2, gen(_names)),
                        spacing(),
                        BuildKey(3, gen(_names)),
                        spacing(),
                        BuildKey(4, gen(_names)),
                        spacing(),
                        BuildKey(5, gen(_names)),
                        spacing(),
                        BuildKey(6, 'kimbean'),
                        spacing(),
                        BuildKey(7, gen(_names)),
                        spacing(),
                        BuildKey(8, gen(_names)),
                        spacing(),
                        BuildKey(9, gen(_names)),
                        spacing(),
                        BuildKey(10, gen(_names)),
                        spacing(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            posts(Random().nextInt(999), Random().nextInt(10) + 1,
                _pics.elementAt(0), gen(_names), gen(_places)),
            posts(Random().nextInt(999), Random().nextInt(10) + 1,
                _pics.elementAt(2), gen(_names), gen(_places)),
            posts(Random().nextInt(999), Random().nextInt(10) + 1,
                _pics.elementAt(3), gen(_names), gen(_places)),
            posts(Random().nextInt(999), Random().nextInt(10) + 1,
                _pics.elementAt(4), gen(_names), gen(_places)),
            posts(Random().nextInt(999), Random().nextInt(10) + 1,
                _pics.elementAt(5), gen(_names), gen(_places)),
            posts(Random().nextInt(999), Random().nextInt(10) + 1,
                _pics.elementAt(6), gen(_names), gen(_places)),
            posts(Random().nextInt(999), Random().nextInt(10) + 1,
                _pics.elementAt(7), gen(_names), gen(_places)),
            posts(Random().nextInt(999), Random().nextInt(10) + 1,
                _pics.elementAt(8), gen(_names), gen(_places)),
            posts(Random().nextInt(999), Random().nextInt(10) + 1,
                _pics.elementAt(9), gen(_names), gen(_places)),
            posts(Random().nextInt(999), Random().nextInt(10) + 1,
                _pics.elementAt(10), gen(_names), gen(_places)),
            posts(Random().nextInt(999), Random().nextInt(10) + 1,
                _pics.elementAt(11), gen(_names), gen(_places)),
            posts(Random().nextInt(999), Random().nextInt(10) + 1,
                _pics.elementAt(12), gen(_names), gen(_places)),
            posts(Random().nextInt(999), Random().nextInt(10) + 1,
                _pics.elementAt(13), gen(_names), gen(_places)),
            posts(Random().nextInt(999), Random().nextInt(10) + 1,
                _pics.elementAt(14), gen(_names), gen(_places)),
            posts(Random().nextInt(999), Random().nextInt(10) + 1,
                _pics.elementAt(15), gen(_names), gen(_places)),
            posts(Random().nextInt(999), Random().nextInt(10) + 1,
                _pics.elementAt(16), gen(_names), gen(_places)),
            posts(Random().nextInt(999), Random().nextInt(10) + 1,
                _pics.elementAt(17), gen(_names), gen(_places)),
            posts(Random().nextInt(999), Random().nextInt(10) + 1,
                _pics.elementAt(1), gen(_names), gen(_places)),
          ],
        ),
      ],
    );
  }
}

class Explore extends StatelessWidget {
//   @override
//   _ExploreState createState() => _ExploreState();
// }

// class _ExploreState extends State<Explore> {

  List<Color> _colors = [
    Colors.red,
    Colors.pink,
    Colors.blue,
    Colors.purple,
    Colors.deepPurple,
    Colors.teal,
    Colors.indigo,
    Colors.cyan,
  ];
  cgen(List<Color> nlis) {
    return nlis.elementAt(Random().nextInt(nlis.length));
  }

  Widget picPost(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Image.network(
        url,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }

  List<String> _names = [
    'ibrahim_kutty',
    'moid_een',
    'arunsmoki',
    'rahulraj_2020',
    'kimbean',
    'tony_stark',
    'peter_parker',
    'amelia_desuza',
    'akshayvlogger',
    'karthiksur_ya',
    'rasput_david',
    'juan',
    'kan_nan'
  ];
  List<String> _places = [
    'Kottayam',
    'Enathu',
    'Adoor',
    'Pathanamthitta',
    'OceanView',
    'Miami',
    'Newzealand',
    'Niagara',
    'Kerala',
    'Mumbai',
    'Paradise',
    'Pandalam',
    'Eranakulam',
    'Bhopal',
    'Kanyakumari'
  ];

  @override
  Widget build(BuildContext context) {
    Widget tagBuild(String tag, Color color) {
      return GestureDetector(
        onTap: (){
          Toast.show("This feature will be available soon!", context,
              duration: Toast.LENGTH_SHORT,
              gravity: Toast.BOTTOM);
        },
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: color,
          shadowColor: color,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Text(
              '$tag',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Metropolis',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          elevation: 20.0,
        ),
      );
    }
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            Toast.show("This feature is not yet available!", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            height: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.grey.shade400,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Search',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Metropolis',
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.search),
                ),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              tagBuild('Travel', Colors.pink),
              tagBuild('Architecture', cgen(_colors)),
              tagBuild('Travel', cgen(_colors)),
              tagBuild('Technology', cgen(_colors)),
              tagBuild('Flutter', cgen(_colors)),
              tagBuild('Python', cgen(_colors)),
              tagBuild('Reactjs', cgen(_colors)),
              tagBuild('Business', cgen(_colors)),
              tagBuild('Design', cgen(_colors)),
              tagBuild('Fashion', cgen(_colors)),
              tagBuild('Music', cgen(_colors)),
            ],
          ),
        ),
        // SizedBox(
        //   height: 20.0,
        // ),

        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32)
                  ),
                      image:DecorationImage(
                        image:AssetImage('images/xplore1.gif'),
                        fit: BoxFit.cover
                      ),
                ),

              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(32)
                  ),
                  image:DecorationImage(
                      image:AssetImage('images/xplore1.jpg'),
                      fit: BoxFit.cover
                  ),
                ),

              ),
              Container(
                decoration: BoxDecoration(

                  image:DecorationImage(
                      image:AssetImage('images/vrphoto.jfif'),
                      fit: BoxFit.cover
                  ),
                ),

              ),
              Container(
                decoration: BoxDecoration(
                  image:DecorationImage(
                      image:AssetImage('images/xplore2.jpg'),
                      fit: BoxFit.cover
                  ),
                ),

              ),
              Container(
                decoration: BoxDecoration(
                  image:DecorationImage(
                      image:AssetImage('images/macbookpurp.jfif'),
                      fit: BoxFit.cover
                  ),
                ),

              ),
              Container(
                decoration: BoxDecoration(
                  image:DecorationImage(
                      image:AssetImage('images/Lambo.jfif'),
                      fit: BoxFit.cover
                  ),
                ),

              ),
              Container(
                decoration: BoxDecoration(
                  image:DecorationImage(
                      image:AssetImage('images/post3.gif'),
                      fit: BoxFit.cover
                  ),
                ),

              ),
              Container(
                decoration: BoxDecoration(
                  image:DecorationImage(
                      image:AssetImage('images/lbridge.jfif'),
                      fit: BoxFit.cover
                  ),
                ),

              ),
              Container(
                decoration: BoxDecoration(
                  image:DecorationImage(
                      image:AssetImage('images/post5.gif'),
                      fit: BoxFit.cover
                  ),
                ),

              ),
              Container(
                decoration: BoxDecoration(

                  image:DecorationImage(
                      image:AssetImage('images/post2.jpg'),
                      fit: BoxFit.cover
                  ),
                ),

              ),
              Container(
                decoration: BoxDecoration(

                  image:DecorationImage(
                      image:AssetImage('images/purpleps.jfif'),
                      fit: BoxFit.cover
                  ),
                ),

              ),



            ],
          ),
        ),
      ],
    );
  }
}

class Create extends StatelessWidget {
  const Create({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: double.infinity,
            margin: EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              image: DecorationImage(
                image: AssetImage('images/create.gif'),
                fit: BoxFit.cover,

              ),
            ),
          ),
        ),
        Expanded(child: Text('This page will be available soon!',
          style: TextStyle(
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.bold,
          ),),)
      ],
    );
  }
}


class Activity extends StatelessWidget {
  List<String> _names = [
    'ibrahim_kutty',
    'moid_een',
    'arunsmoki',
    'rahulraj_2020',
    'kimbean',
    'tony_stark',
    'peter_parker',
    'amelia_desuza',
    'akshayvlogger',
    'karthiksur_ya',
    'rasput_david',
    'juan',
    'kan_nan'
  ];
  List<String> _places = [
    'Kottayam',
    'Enathu',
    'Adoor',
    'Pathanamthitta',
    'OceanView',
    'Miami',
    'Newzealand',
    'Niagara',
    'Kerala',
    'Mumbai',
    'Paradise',
    'Pandalam',
    'Eranakulam',
    'Bhopal',
    'Kanyakumari'
  ];

  @override
  Widget build(BuildContext context) {
    ListTile _followList(int num, String name, String place) {
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('images/usr$num.jfif'),
          radius: 28.0,
        ),
        title: Text(
          name,
          style: TextStyle(
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
        subtitle: Text(
          place,
          style: TextStyle(
            fontFamily: 'Metropolis',
            fontSize: 12.0,
          ),
        ),
        trailing: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.userPlus,
            color: Colors.blueAccent,
            size: 19.0,
          ),
        ),
        onTap: () {
          Toast.show("Following list updated!", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        },
      );
    }

    return ListView(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Card(
                margin: EdgeInsets.fromLTRB(10.0, 20.0, 3.0, 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 30.0,
                shadowColor: Colors.pink,
                child: Container(
                  padding: EdgeInsets.fromLTRB(15.0, 20.0, 50.0, 15.0),
                  height: 101.0,
                  width: 169.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'New Followers',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Last 7 days',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Metropolis',
                            fontSize: 10.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        '265',
                        style: TextStyle(
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.pink, Colors.redAccent, Colors.orange],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            //Todo: Randomise Profile pics
            //Todo: Randomise Network images
            Expanded(
              child: Card(
                margin: EdgeInsets.fromLTRB(8.0, 20.0, 10.0, 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 30.0,
                shadowColor: Colors.blue,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 50.0, 10.0),
                  height: 101.0,
                  width: 162.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Unfollowed',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Last 7 days',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Metropolis',
                            fontSize: 10.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        '82',
                        style: TextStyle(
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple,
                          Colors.deepPurple,
                          Colors.blueAccent
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
          ],
        ),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
        _followList(Random().nextInt(10) + 1, gen(_names), gen(_places)),
      ],
    );
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('images/xplore1.gif'),
                  radius: 40.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text('Pranav Ajay',
                  style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'Metropolis',
                    fontWeight: FontWeight.bold
                  ),)
              ],
            ),
            Column(
              children: <Widget>[
                Text('0',
                  style:TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ) ,),
                SizedBox(
                  height: 5.0,
                ),
                Text('Posts',
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Metropolis'
                ),)
              ],

            ),
            Column(
              children: <Widget>[
                Text('7,500',
                  style:TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ) ,),
                SizedBox(
                  height: 5.0,
                ),
                Text('Followers',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Metropolis'
                  ),)
              ],


            ),
            Column(
              children: <Widget>[
                Text('10',
                  style:TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ) ,),
                SizedBox(
                  height: 5.0,
                ),
                Text('Following',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Metropolis'
                  ),)
              ],


            ),
          ],
        ),
      ),
        SizedBox(
          height: 30.0,
        ),
        ElevatedButton(onPressed: () =>  Toast.show("This feature is not yet available!", context,
                duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM),
                 child: Padding(
                   padding: const EdgeInsets.fromLTRB(110.0,0.0,110.0,0.0),
                   child: Text('Edit Profile',style: TextStyle(color: Colors.black,
                   fontFamily: 'Metropolis',
                   fontWeight: FontWeight.bold),),
                 ),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
          ),
        ),
    ],
    );
  }
}

//         Icon(Icons.home, size: 30.0),
//         Icon(Icons.search, size: 30.0),
//         Icon(Icons.create_outlined, size: 30.0),
//         Icon(Icons.mood_sharp, size: 30.0),
//         Icon(Icons.person_outline, size: 30.0),
