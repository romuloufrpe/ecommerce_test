import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:historias/component/app_tools.dart';

class FireBaseMethods {
  Firestore _firestore = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  // !user details
  String userID = "userID";
  String acctFullName = "acctFullName";
  String phoneNumber = "phoneNumber";
  String userEmail = "userEmail";
  String userPassword = "userPassword";
  String photoURL = "photoURL";
  String loggedIN = "loggedIN";
  String state = "";

  Future<String> createUserAccount(
      {String fullname, String phone, String email, String password}) async {
    // TODO implement createAccount
    FirebaseUser user;

    user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (user != null) {
      await _firestore.collection("users").document(user.uid).setData({
        userID: user.uid,
        acctFullName: fullname,
        userEmail: email,
        userPassword: password,
        phoneNumber: phone
      });

      await writeDataLocally(key: userID, value: user.uid);
      await writeDataLocally(key: acctFullName, value: fullname);
      await writeDataLocally(key: userEmail, value: email);
      await writeDataLocally(key: userPassword, value: password);
      await writeDataLocally(key: phoneNumber, value: phone);
    }
    return user.uid;
  }

  Future<String> logginUser({String email, String password}) async {
    FirebaseUser user;

    // TODO implemet Login user email e password
    try {
      user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        DocumentSnapshot userInfo = await getUserInfo(user.uid);
        await writeDataLocally(key: userID, value: userInfo[userID]);
        await writeDataLocally(
            key: acctFullName, value: userInfo[acctFullName]);
        await writeDataLocally(key: userEmail, value: userInfo[email]);
        // await writeDataLocally(key: photoURL, value: userInfo[photoURL]);
        await writeDataLocally(key: phoneNumber, value: userInfo[phoneNumber]);
        await writeBoolDataLocally(key: loggedIN, value: true);

        print(userInfo[userEmail]);
        print(userInfo[acctFullName]);

        state = "successful";
        switch (state) {
          case "successful":
              //print(currentUser().toString());
              return state;
          default:
        }
      }
    } catch (e) {
      print(e.toString());
    }

    return "notsuccessful";
  }

  Future<DocumentSnapshot> getUserInfo(String userid) async {
    return await _firestore.collection("users").document(userid).get();
  }

  Future<String> currentUser() async {
    var user = await auth.currentUser();
    return user?.uid;
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await auth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await auth.currentUser();
    return user.isEmailVerified;
  }
}
