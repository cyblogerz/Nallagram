import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: FaIcon(FontAwesomeIcons.userPlus),
            title: Text("Follow and Invite Friends  "),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.bell),
            title: Text("Notifications"),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.lock),
            title: Text("Privacy"),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.shieldAlt),
            title: Text("Security"),
          ),
          ListTile(
              leading: FaIcon(FontAwesomeIcons.user), title: Text("Account")),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.questionCircle),
            title: Text("Help"),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.exclamationCircle),
            title: Text("About"),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.signOutAlt),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
