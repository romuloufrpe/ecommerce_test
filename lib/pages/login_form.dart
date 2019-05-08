import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:historias/component/app_tools.dart';
import 'package:historias/component/create_account_button.dart';
import 'package:historias/component/google_login_button.dart';
import 'package:historias/component/login_button.dart';
import 'package:historias/db/user_repository.dart';
import 'package:historias/authentication_bloc/bloc.dart';
import 'package:historias/pages/login_bloc/bloc.dart';
import 'package:historias/pages/login_bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormvalid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _loginBloc,
      listener: (BuildContext context, LoginState state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Erro ao fazer login'),
                    Icon(Icons.error)
                  ],
                ),
                backgroundColor: Colors.red[700],
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Acessando...'),
                    CircularProgressIndicator()
                  ],
                ),
              ),
            );
        }
        if(state.isSuccess){
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
        }
      },
      child: BlocBuilder(
        bloc: _loginBloc,
        builder: (BuildContext context, LoginState state){
          return new Stack(
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
                controller: _emailController),
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
                controller: _passwordController,),
          ),
          Padding(
            padding: EdgeInsets.only(top: 480.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                LoginButton(
                  onPressed: isLoginButtonEnabled(state)
                  ? _onFormSubmitted
                  : null,
                ),
                Padding(
                  padding: EdgeInsets.only(top:10.0),
                  child: new GoogleLoginButton(),        
                ),
                Padding(
                  padding: EdgeInsets.only(top:20.0),
                  child: CreateAccountButton(userRepository: _userRepository),
                )
              ],
            ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void _onEmailChanged() {
    _loginBloc.dispatch(
      EmailChanged(email: _emailController.text),
    );
  }

  @override
  void _onPasswordChanged(){
    _loginBloc.dispatch(
      PasswordChanged(password: _passwordController.text)
    );
  }
  @override
  void _onFormSubmitted(){
    _loginBloc.dispatch(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text
      ),
    );
  }
}
