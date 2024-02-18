

import 'package:firebase_auth/firebase_auth.dart';

class FirAuth{
  
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signUpwithEmail(String email, String password) async{
    try {
    UserCredential user = await auth.createUserWithEmailAndPassword(email: email, password: password);
    return user.user;
    } catch (e) {
      print("error");
    }
    return null;
  
  
  }
  Future<User?> signInwithEmail(String email, String password) async{
    try {
    UserCredential user = await auth.signInWithEmailAndPassword(email: email, password: password);
    return user.user;
    } catch (e) {
      print("error");
    }
    return null;
  }
}