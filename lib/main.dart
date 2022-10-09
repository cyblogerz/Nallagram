import 'package:flutter/material.dart';
import 'package:nallagram/firebase_options.dart';
import 'package:nallagram/nav.dart';
import 'package:nallagram/screens/Authenticate/login_screen.dart';
import 'package:nallagram/screens/Chat/calls_chat.dart';
import 'package:nallagram/screens/Chat/new_message_chat.dart';
import 'package:provider/provider.dart';
import 'screens/Authenticate/welcome_screen.dart';
import 'screens/Authenticate/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'root.dart';
import 'screens/Chat/chat_home.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          NewMessageChat.id: (context) => NewMessageChat(),
          ChatHome.id: (context) => ChatHome(),
          CallsChat.id: (context) => CallsChat(),
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
