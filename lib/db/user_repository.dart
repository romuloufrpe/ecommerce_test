import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

Firestore _firestore = Firestore.instance;
// !user details
  String userID = "userID";
  String acctFullName = "acctFullName";
  String phoneNumber = "phoneNumber";
  String userEmail = "userEmail";
  String userPassword = "userPassword";

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.accessToken);
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

   Future<void> signUp({String email, String password, String fullname, String phone}) async {
     FirebaseUser user;
     user = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (user != null) {
      await _firestore.collection("users").document(user.uid).setData({
        userID: user.uid,
        acctFullName: fullname,
        userEmail: email,
        userPassword: password,
        phoneNumber: phone
      });
      return user.uid;
  }
   }

  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  Future<bool> isSigned() async{
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUserEmail()async{
    return(await _firebaseAuth.currentUser()).email;
  }

  Future<String> getUserName()async{
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
    final QuerySnapshot result = await Firestore.instance
    .collection("users")
    .where(userID, isEqualTo: firebaseUser.uid)
    .getDocuments();
    final List<DocumentSnapshot> document = result.documents;
    
    return(await document[0][acctFullName]);
  }
}
