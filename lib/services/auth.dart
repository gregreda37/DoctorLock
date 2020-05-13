import 'package:doc_lock/models/user.dart';
import 'package:doc_lock/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user){

    return user != null ? User(uid: user.uid) : null;

  }

  //auth change user stream
  //<Object> we will use our User object we created above.
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);


  }

  //sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
  //sign in email password
    Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    } catch(e) {
      print(e.toString());
      return null;

    }

  }

  //register email password
  Future registerWithEmailAndPassword(String email, String password, String name) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      //create doc for new user

      await DatabaseService(uid: user.uid).updateUserData("0"," ",100,name);

      return _userFromFirebaseUser(user);

    } catch(e) {
      print(e.toString());
      return null;

    }

  }

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }

  }
  


}