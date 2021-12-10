// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nallagram/nav.dart';
import 'package:nallagram/screens/Authenticate/login_screen.dart';
import 'package:provider/provider.dart';
import 'screens/Authenticate/welcome_screen.dart';
import 'screens/Authenticate/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'root.dart';
// import 'chat_screen.dart';
import 'screens/Chat/chat_home.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
            create: (_) => AuthenticationProvider(FirebaseAuth.instance)),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationProvider>().authStateChanges)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Authenticate.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          // ChatScreen.id: (context) => ChatScreen(),
          ChatHome.id: (context) => ChatHome(),
          Nav.id: (context) => Nav(),
          Register.id: (context) => Register(),
          Welcome.id: (context) => Welcome(),
          Authenticate.id: (context) => Authenticate(),
        },
      ),
    );
  }
}

class Authenticate extends StatelessWidget {
  static const id = 'auth';
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return Nav();
    }

    return Welcome();
  }
}
