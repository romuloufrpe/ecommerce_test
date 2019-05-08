import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historias/db/user_repository.dart';
import 'package:historias/db/users.dart';
import 'package:historias/pages/register/bloc/bloc.dart';
import 'package:historias/pages/register/register_form.dart';
import 'package:historias/ui/home.dart';
import 'package:historias/component/app_tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historias/db/firebaseMethods.dart';

class SignUp extends StatefulWidget {
  final UserRepository _userRepository;

  SignUp({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc(
      userRepository: widget._userRepository
    );
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: BlocProvider<RegisterBloc>(
          bloc: _registerBloc,
          child: RegisterForm(),
        ),
      ),
    );
  }

  @override
  void dispose(){
    _registerBloc.dispose();
    super.dispose();
  }

  /*final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  UserServices _userServices = UserServices();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordConfirm = TextEditingController();

  FireBaseMethods appMethods = FireBaseMethods();

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
                          child: appTextField(
                              isPassword: false,
                              textHint: "Nome",
                              textIcon: FontAwesomeIcons.user,
                              controller: _name),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: appTextField(
                              isPassword: false,
                              textHint: "E-mail",
                              textIcon: FontAwesomeIcons.envelope,
                              controller: _email),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: appTextField(
                              isPassword: false,
                              textHint: "Número de telefone",
                              textIcon: FontAwesomeIcons.mobileAlt,
                              controller: _phone,
                              textType: TextInputType.number),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: appTextField(
                              isPassword: true,
                              textHint: "Senha",
                              textIcon: Icons.lock_outline,
                              controller: _password),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: appTextField(
                              isPassword: true,
                              textHint: "Confirme a Senha",
                              textIcon: Icons.lock_outline,
                              controller: _passwordConfirm),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: appButton(
                              btnTxt: "Criar conta",
                              onBtnclicked: validateFrom,
                              btnPadding: 20.0,
                              btnColor: Colors.orange),
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

  Future validateFrom() async {
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
      formState.reset();
      FirebaseUser user = await firebaseAuth.currentUser();
      if (user == null) {
        appMethods.createUserAccount(
            email: _email.text,
            fullname: _name.text,
            phone: _phone.text,
            password: _password.text);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }*/
}
