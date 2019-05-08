import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historias/authentication_bloc/bloc.dart';
import 'package:historias/component/app_tools.dart';
import 'package:historias/pages/register/bloc/bloc.dart';
import 'package:historias/pages/register/register_button.dart';

class RegisterForm extends StatefulWidget {
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordConfirm = TextEditingController();

  RegisterBloc _registerBloc;

  bool get isPopulated => _email.text.isNotEmpty && _password.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _email.addListener(_onEmailChanged);
    _password.addListener(_onPasswordChanged);
    _name.addListener(_onNameChanged);
    _phone.addListener(_onPhoneChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _registerBloc,
      listener: (BuildContext context, RegisterState state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Registrando...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Erro ao criar conta'),
                  Icon(Icons.error)
                ],
              ),
              backgroundColor: Colors.red,
            ));
        }
      },
      child: BlocBuilder(
        bloc: _registerBloc,
        builder: (BuildContext context, RegisterState state) {
          return new Scaffold(
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
                          RegisterButton(
                            onPressed: isRegisterButtonEnabled(state)
                                ? _onFormSubmitted
                                : null,
                          )
                        ],
                      )),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.dispatch(
      EmailChanged(email: _email.text)
    );
  }

  void _onPasswordChanged(){
    _registerBloc.dispatch(
      PasswordChanged(password: _password.text)
    );
  }

  void _onNameChanged(){
    _registerBloc.dispatch(
      NameChanged(name: _name.text)
    );
  }

  void _onPhoneChanged(){
    _registerBloc.dispatch(
      PhoneChanged(phone: _phone.text)
    );
  }

  void _onFormSubmitted(){
    _registerBloc.dispatch(
      Submitted(
        email: _email.text,
        password: _password.text
      )
    );
  }
}
