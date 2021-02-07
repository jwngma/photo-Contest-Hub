import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photocontesthub/models/users.dart';
import 'package:photocontesthub/utils/Constants.dart';
import 'package:photocontesthub/utils/tools.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

@immutable
class User {
  final String uid;

  const User({@required this.uid});
}

class FirebaseAuthServices {
  final _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final Firestore firestore = Firestore.instance;

  Users users = Users();

  User _userFromFirebase(FirebaseUser user) {
    return user == null ? null : User(uid: user.uid);
  }

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _firebaseAuth.currentUser();

    return currentUser;
  }

  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

// create with gmail
  Future<FirebaseUser> signInWithGoogle() async {
    print("Login With Google");
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      print("Login With Google is not null");
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      print(authCredential.toString());

      FirebaseUser user =
          (await _firebaseAuth.signInWithCredential(authCredential)).user;

      return user;
    } else {
      return null;
    }
  }

  // create with email and apssword
  Future<FirebaseUser> createUserWithEmailAndPassword(
      String email, String name, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    print("New user Created with Email and password");
    var userinfo = UserUpdateInfo();
    userinfo.displayName = name;
    FirebaseUser currentUser;
    if (authResult != null) {
      currentUser = authResult.user;
      await currentUser.updateProfile(userinfo);
      await currentUser.reload();
    }
    return currentUser;
  }

  // login
  Future<FirebaseUser> signInWithEmailAndPassword(
      String email, String password) async {
    final auth_result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    if (auth_result != null) {
      FirebaseUser currentUser = auth_result.user;
      return currentUser;
    }
  }

  Future<bool> authenticateUser(FirebaseUser firebaseUser) async {
    QuerySnapshot querySnapshot = await firestore
        .collection(Constants.Users)
        .where("email", isEqualTo: firebaseUser.email)
        .getDocuments();

    List<DocumentSnapshot> docs = querySnapshot.documents;

    return docs.length > 0 ? false : true;
  }

  Future<void> addToDb(FirebaseUser currentuser) async {
    String username = Tools.getUsername(currentuser.email);
    print(username);
    users = Users(
        uid: currentuser.uid,
        email: currentuser.email,
        name: currentuser.displayName,
        username: username,
        amount: 0,
        profile_photo: currentuser.photoUrl);

    firestore
        .collection(Constants.Users)
        .document(currentuser.uid)
        .setData(users.toMap(users));
  }

  Future<void> UpdateUserProfile(Users users) async {
    var map = Map<String, dynamic>();
    map["name"] = users.name;
    map["email"] = users.email;
    map["pubg_name"] = users.facebook_name;
    await firestore
        .collection(Constants.Users)
        .document(users.uid)
        .updateData(map);
  }

  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future signOutWhenGoogle() async {
    print("Logout Called");
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await _firebaseAuth.signOut();
  }
}
