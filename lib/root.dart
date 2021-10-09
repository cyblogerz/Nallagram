import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  notLoggedIn,
  loggedIn,
}

class AuthenticationProvider {
  final FirebaseAuth firebaseAuth;
// FirebaseAuth instance
  AuthenticationProvider(this.firebaseAuth);
//Constructor to initialize the Firebase Auth instance.
  Stream<User> get authStateChanges => firebaseAuth.idTokenChanges();
}
