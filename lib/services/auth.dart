import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GUser{

  GUser({@required this.uid});
  final String uid;
}
abstract class AuthBase{
  Stream<GUser> get onAuthStateChanged;
  Future<GUser> currentUser();
  Future<GUser> signInAnonymously();
  Future<GUser> signInWithGoogle();
  Future<GUser> createUserWithEmailAndPassword(String email, String password);
  Future<GUser> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}
class Auth implements AuthBase{
  final _firebaseAuth = FirebaseAuth.instance;

  GUser _userFromFirebase(User user){
    if (user==null){
      return null;
    }
    return GUser(uid: user.uid);
  }
  @override
  Stream<GUser> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }
  @override
  Future<GUser> currentUser()async{
    final user =  _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }
  @override
  Future<GUser> signInAnonymously() async {
    UserCredential userCredential = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(userCredential.user);
  }
  @override
  Future<GUser> signInWithEmailAndPassword(String email, String password) async{
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }
  @override
  Future<GUser> createUserWithEmailAndPassword(String email, String password) async{
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password );
    return _userFromFirebase(authResult.user);
  }
  @override
  Future<GUser> signInWithGoogle() async{
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount!=null){
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken!=null && googleAuth.idToken!=null){
        final authResult = await _firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(idToken: googleAuth.idToken,accessToken: googleAuth.accessToken),);
        return _userFromFirebase(authResult.user);
      }
      else {
        throw PlatformException(
            code: 'ErrorMissingGoogleAuthToken',
            message: 'Missing Google AuthToken'
        );
      }
    }
    else {
      throw PlatformException(
          code: 'ErrorAbortedByUser',
          message: 'Sign In Aborted By User'
      );
    }
  }
  @override
  Future<void> signOut() async {
      await _firebaseAuth.signOut();
    }

}