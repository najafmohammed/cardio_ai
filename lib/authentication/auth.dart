import 'package:cardio_ai/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth =FirebaseAuth.instance;
  //user object for firebase user
  UserModel _userFromFirebaseUser(User user){
    return user !=null ? UserModel(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<UserModel> get user{
    return _auth.authStateChanges()
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
  Future signInwithEmailAndPassword(String email,String password)async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString()) ;
      return null;
    }
  }

  // register with email and password
  Future regWithEmailAndPassword(String email,String password,String userName)async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      final CollectionReference record =
      FirebaseFirestore.instance.collection('Patient Record');
      record.doc(user.uid).set({"name":userName});
      //create a new document for storing user data
      // await DatabaseService(uid:user.uid).setUserData(1, 'n/a', 'n/a','n/a', 'n/a','n/a', 'n/a', 'n/a','n/a',false);
      // await DatabaseService(uid: user.uid).updateName(userName);
      // print(DatabaseService);
      print("REGISTER DONE:::");
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signout() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}