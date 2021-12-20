import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:nallagram/screens/Explore/explore_page.dart';
import 'package:nallagram/screens/blog/blog_home.dart';
import 'screens/Activity/activity_page.dart';
import 'package:nallagram/screens/Home/home.dart';
import 'screens/Create/create_page.dart';
import 'screens/Chat/chat_home.dart';
import 'screens/Profile/profile.dart';

final _auth = FirebaseAuth.instance;
User loggedInUser = _auth.currentUser;

class Nav extends StatefulWidget {
  static const String id = 'nav';
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    // _getToken();
    getProfileData();
    // getProfileData();
  }

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
    Profile(),
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
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'Nallagram',
          style: TextStyle(
            fontFamily: 'Metropolis',
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -1,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => BlogHome()));
            },
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.pink, Colors.redAccent, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(Icons.notes_rounded),
            ),
          ),
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.paperPlane,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, ChatHome.id);
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
        ],
        index: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
