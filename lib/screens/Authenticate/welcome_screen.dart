import 'package:flutter/material.dart';
import 'package:nallagram/screens/Authenticate/register_screen.dart';
import 'login_screen.dart';

class Welcome extends StatefulWidget {
  static const String id = 'welcome';
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Center(
              child: Hero(
                tag: 'logo',
                child: Text('Nallagram',
                    style: TextStyle(
                      fontFamily: 'Billabong',
                      color: Colors.black,
                      fontSize: 70.0,
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                    child: Container(
                      // padding: EdgeInsets.fromLTRB(20.0, 20.0, 50.0, 10.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
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
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Divider(
                          thickness: 2.0,
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'OR',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 2.0,
                        ))
                      ],
                    ),
                  ),
                  MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Register.id);
                      },
                      child: Text('Sign up with Email')),
                  SizedBox(
                    height: 80.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
