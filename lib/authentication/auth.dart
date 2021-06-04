import 'package:cardio_ai/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //user object for firebase user
  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<UserModel> get user {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  //sign in anonymously
  // Future signInAnon() async{
  //   try{
  //     UserCredential authResult =  await _auth.signInAnonymously();
  //     User user = authResult.user;
  //     return _userFromFirebaseUser(user);
  //   }catch(e){
  //     print(e/toString());
  //     return null;
  //   }
  // }

  //sign in with email and password
  Future signInwithEmailAndPassword(String email, String password) async {
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

  // register with email and password
  Future regWithEmailAndPassword(
      String email, String password, String userName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      final CollectionReference record =
          FirebaseFirestore.instance.collection('Patient Record');
      final CollectionReference global =
          FirebaseFirestore.instance.collection('Global');
      var _op = await global.doc("OP").get();
      var op = _op.get("value");
      DateTime date = DateTime.now();
      await record.doc(user.uid).set({
        "name": userName,
        "op number": op + 1,
        "new": true,
        "date":date,
        "entry": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3]
      });
      await global.doc("OP").update({"value": op + 1});
      print("REGISTER DONE:::");
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
