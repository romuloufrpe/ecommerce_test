import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:historias/ui/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  SharedPreferences preferences;
  bool loading = false;
  bool isLogedin = false;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    FirebaseUser firebaseUser =
        await firebaseAuth.signInWithCredential(credential);

    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;

      if (documents.length == 0) {
        // insert the user a collection
        Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .setData({
          "id": firebaseUser.uid,
          "username": firebaseUser.displayName,
          "profile": firebaseUser.photoUrl,
          "email": firebaseUser.email
        });
        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("username", firebaseUser.displayName);
        await preferences.setString("photoUrl", firebaseUser.displayName);
      } else {
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[0]['username']);
        await preferences.setString("photoUrl", documents[0]['photoUrl']);
      }
      //showInSnackBar("Login Realizado com Sucesso!");
      setState(() {
        loading = false;
      });
    } else {}
    assert(firebaseUser.email != null);
    assert(firebaseUser.displayName != null);
    assert(!firebaseUser.isAnonymous);
    assert(await firebaseUser.getIdToken() != null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/img/bg_login.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.all(70.0),
              child: Image.asset("assets/img/logo.png"),
            ),
          ),
          Container(
            color: Colors.orange.withOpacity(0.2),
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
              alignment: Alignment.center,
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white.withOpacity(0.5),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                controller: _emailTextController,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  icon: Icon(Icons.email),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(value)) {
                                      return "Porfavor entre com um e-mail válido!";
                                    } else {
                                      return null;
                                    }
                                  }
                                },
                              ),
                            )),
                      ),
//                   ===================== Field Password
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white.withOpacity(0.5),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                controller: _passwordTextController,
                                decoration: InputDecoration(
                                  hintText: "Senha",
                                  icon: Icon(Icons.lock_outline),
                                ),
                                validator: (value) {
                                  
                                },
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              )),
          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          child: Padding(
        padding:
            EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
        child: FlatButton(
          color: Colors.orange.shade900,
          onPressed: () {
            handleSignIn();
          },
          child: Text(
            "Login com Google",
            style: TextStyle(color: Colors.white),
          ),
        ),
      )),
    );
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });
    preferences = await SharedPreferences.getInstance();
    isLogedin = await googleSignIn.isSignedIn();
    if (isLogedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    setState(() {
      loading = false;
    });
  }

  /*void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }*/
}
