import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kodelab/models/user.dart';
import 'package:kodelab/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on firebaseUSer
  Userr _userFromFirebaseUser(User user) {
    return user != null ? Userr(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.authStateChanges();
  }

  //sign in anons
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sing in with email & pass
  Future signInWithEmailandPassword(String email, String password) async {
    {
      try {
        UserCredential result = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        User user = result.user;
        return _userFromFirebaseUser(user);
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
  }

  // //delete user
  // Future deleteUser(String uid) async {
  //   await _auth.sendPasswordResetEmail(: email);
  // }

  //register with email & pass
  Future registerWithEmailandPassword(String firstName, String lastName,
      String email, String password, int sex, String qualification) async {
    {
      try {
        UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        User user = result.user;

        await DatabaseService(uid: user.uid)
            .updateUserData(firstName, lastName, email, sex, qualification);

        return _userFromFirebaseUser(user);
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

class AuthResult {}
