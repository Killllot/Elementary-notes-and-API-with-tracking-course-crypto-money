import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';

class AuthService with ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;



  Future signInEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future registerEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      // return user;
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

  Future logOut() async {
    await _firebaseAuth.signOut();
  }

  Stream get currentUser => _firebaseAuth.authStateChanges().map((event) => event);
}
