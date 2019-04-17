import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historias/db/users.dart';
import 'package:historias/ui/home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  UserServices _userServices = UserServices();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _passwordConfirmTextController =
      TextEditingController();

  String gender;
  String groupValue = "male";

  bool loading = false;
  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/img/bg_logiin.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/img/logo.png",
                  width: 280.0,
                  height: 240.0,
                )),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 280.0),
              child: Center(
                child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                controller: _nameTextController,
                                decoration: InputDecoration(
                                    hintText: "Nome",
                                    icon: Icon(FontAwesomeIcons.user),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                controller: _emailTextController,
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    icon: Icon(Icons.alternate_email),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(value))
                                      return 'Entre com um email válido';
                                    else
                                      return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: ListTile(
                                title: TextFormField(
                                  controller: _passwordTextController,
                                  obscureText: hidePass,
                                  decoration: InputDecoration(
                                      hintText: "Senha",
                                      icon: Icon(Icons.lock_outline),
                                      border: InputBorder.none),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "O campo senha está vazio";
                                    } else if (value.length < 6) {
                                      return "A senha Precissa conter mais que 6 caracteres";
                                    }
                                    return null;
                                  },
                                ),
                                trailing: IconButton(
                                  icon: Icon(FontAwesomeIcons.eye),
                                  onPressed: () {
                                    setState(() {
                                      if (hidePass == true) {
                                        hidePass = false;
                                      } else if (hidePass == false) {
                                        hidePass = true;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: ListTile(
                                title: TextFormField(
                                  controller: _passwordConfirmTextController,
                                  obscureText: hidePass,
                                  decoration: InputDecoration(
                                      hintText: "Entre com a senha novamente",
                                      icon: Icon(Icons.lock_outline),
                                      border: InputBorder.none),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "O campo senha está vazio";
                                    } else if (value.length < 6) {
                                      return "A senha Precissa conter mais que 6 caracteres";
                                    } else if (_passwordTextController.text !=
                                        value) {
                                      return "As senhas não são iguais";
                                    }
                                    return null;
                                  },
                                ),
                                trailing: IconButton(
                                  icon: Icon(FontAwesomeIcons.eye),
                                  onPressed: () {
                                    setState(() {
                                      if (hidePass == true) {
                                        hidePass = false;
                                      } else if (hidePass == false) {
                                        hidePass = true;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.orange.shade700,
                              elevation: 0.0,
                              child: MaterialButton(
                                onPressed: () async {
                                  validateFrom();
                                },
                                minWidth: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Criar Conta",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              )),
                        ),
                      ],
                    )),
              ),
            ),
          ),
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
          )
        ],
      ),
    );
  }

  valueChanged(e) {
    setState(() {
      if (e == "male") {
        groupValue = e;
      } else if (e == "female") {
        groupValue = e;
      }
    });
  }

  Future validateFrom() async {
    FormState formState = _formKey.currentState;
    Map value;
    if (formState.validate()) {
      formState.reset();
      FirebaseUser user = await firebaseAuth.currentUser();
      if (user == null) {
        firebaseAuth
            .createUserWithEmailAndPassword(
                email: _emailTextController.text,
                password: _passwordTextController.text)
            .then((user) => {
                  value = {
                    "username": _nameTextController.text,
                    "email": _emailTextController.text,
                    "userId": user.uid
                  },
                  _userServices.createUser(value)
                })
            .catchError((err) => {print(err.toString())});

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }
}
