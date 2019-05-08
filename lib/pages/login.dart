import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:historias/db/user_repository.dart';
import 'package:historias/pages/login_bloc/bloc.dart';
import 'package:historias/pages/login_form.dart';

class Login extends StatefulWidget {
  final UserRepository _userRepository;

  Login({Key key, @required UserRepository userRepository})
  : assert(userRepository != null),
  _userRepository = userRepository,
  super(key:key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState(){
    super.initState();
    _loginBloc = LoginBloc(
      userRepository: _userRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        bloc: _loginBloc,
        child: LoginForm(userRepository: _userRepository),
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}




 /* Future<void> verifyLoggin() async {
    if (email.text == "") {
      return print("Email cannot be empty");
    }

    if (password.text == "") {
      return print("Password cannot be empty");
    }
    try {
      FormState formState = _formKey.currentState;
      
      displayProgressDialog(context);
      String response = await appMethods.logginUser(
          email: email.text.toLowerCase(),
          password: password.text.toLowerCase());
      print(response);
      if (response == "successful") {
        closeProgressDialog(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      else{
        closeProgressDialog(context);
        showSnackBar("Email ou senhas invalidas", scaffoldKey);
        
      }
    } catch (e) {
      print(e.toString());
    }
  }*/

