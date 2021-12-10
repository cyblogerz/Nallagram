import 'package:flutter/material.dart';
import '../../nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  static const String id = 'register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  User user; //never gonna change
  //instance
  String email;
  String password;
  String name;
  List<String> profiles = [
    'https://cdn.dribbble.com/users/86682/screenshots/10441196/penguin.png',
    'https://cdn.dribbble.com/users/1162077/screenshots/7475318/media/8837a0ae1265548e27a2b2bb3ab1f366.png',
    'https://cdn.dribbble.com/users/1162077/screenshots/7495197/media/92507bdcf4b5edfa12d5e9cc4f01b301.png',
    'https://cdn.dribbble.com/users/1162077/screenshots/7542499/media/d6f3265e5017257e5900b762754f2655.png',
    'https://cdn.dribbble.com/users/1162077/screenshots/5940704/media/6a37a16dc390eed6c93f6f5020af211a.png'
  ];
  String photoUrl(List<String> pfls) {
    return pfls.elementAt(Random().nextInt(pfls.length));
  }

  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Hero(
              //   tag: 'logo',
              //   child: Container(
              //     height: 200.0,
              //     child: Image.asset('images/logo.png'),
              //   ),
              // ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  //Do something with the user input.
                  name = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;

                  //Do something with the user input.
                },
                decoration: InputDecoration(
                  hintText: 'Enter a 6 digit password',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });

                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        User user = newUser.user;
                        user.updateDisplayName(name);
                        var pfp = photoUrl(profiles);
                        user.updatePhotoURL(pfp);
                        _store.collection('users').doc(user.uid).set({
                          'name': name,
                          'profile': pfp,
                          'followerlist': [""],
                          'followinglist': [""],
                          'descr':
                              'Tap edit profile to update profile photo and description',
                          'followers': 0,
                          'userid': user.uid,
                          'following': 0,
                          'posts': 0
                        });

                        if (newUser != null) {
                          Navigator.pushNamed(context, Nav.id);
                        }
                      }
                      //Implement registration functionality.
                      //as it is returning a future we assign a final variable to it
                      catch (e) {
                        print(e);
                      } finally {
                        showSpinner = false;
                      }
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
