import 'package:flutter/material.dart';
import 'package:historias/component/app_tools.dart';
import 'package:historias/db/firebaseMethods.dart';
import 'package:historias/pages/signUp.dart';
import 'package:historias/ui/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;
  FireBaseMethods appMethods = FireBaseMethods();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage("assets/img/bg_logiin.jpg"),
                    fit: BoxFit.cover)),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.all(70.0),
              child: Image.asset("assets/img/logo.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 350.0),
            child: appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "E-mail",
                textIcon: Icons.email,
                controller: email),
          ),
          new SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 415.0),
            child: appTextField(
                isPassword: true,
                sidePadding: 18.0,
                textHint: "Senha",
                textIcon: Icons.lock,
                controller: password),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 480.0),
              child: appButton(
                  btnColor: Colors.orange.shade700,
                  btnTxt: "Login",
                  onBtnclicked: verifyLoggin,
                  btnPadding: 20.0)),
          Padding(
            padding: const EdgeInsets.only(top: 560.0),
            child: new GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => new SignUp()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 105.0),
                child: new Text(
                  "Não é cadastrado? Cadastre-se",
                  style: new TextStyle(color: Colors.red),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  verifyLoggin() async {
    if (email.text == "") {
      return print("Email cannot be empty");
    }

    if (password.text == "") {
      return print("Password cannot be empty");
    }

    displayProgressDialog(context);
    String response = await appMethods.logginUser(
        email: email.text.toLowerCase(), password: password.text.toLowerCase());
    if (response == "successful") {
      closeProgressDialog(context);
      Navigator.of(context).pop(true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      closeProgressDialog(context);
      //showSnackBar(response, scaffoldKey);
    }
  }
}
