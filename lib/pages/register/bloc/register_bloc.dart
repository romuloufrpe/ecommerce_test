import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:historias/pages/register/bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:historias/db/user_repository.dart';
import 'package:historias/component/validators.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
  : assert(userRepository != null),
  _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> transform(
    Stream<RegisterEvent> events,
    Stream<RegisterState> Function(RegisterEvent event) next,
  ) {
    final observabelStream = events as Observable<RegisterEvent>;
    final nonDebounceStream  = observabelStream.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = observabelStream.where((event){
      return(event is EmailChanged || event is PasswordChanged);
    }); //.debounce(Duration(milliseconds: 300));
    return super.transform(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream <RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if(event is EmailChanged){
      yield* _mapEmailChangedToState(event.email);
    } else if(event is PasswordChanged){
      yield* _mapPasswordChangedToState(event.password);
    } else if(event is NameChanged){
      yield* _mapNameChangedToState(event.name);
    }else if(event is PhoneChanged){
      yield* _mapPhoneChangedToState(event.phone);
    }
    else if(event is Submitted){
      yield* _mapFormSubmitChangedToState(event.email, event.password, event.name, event.phone);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async*{
    yield currentState.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async*{
    yield currentState.update(
      isPasswordValid: Validators.isValidPassword(password)
    );
  }

  Stream<RegisterState> _mapNameChangedToState(String name) async*{
   
  }

  Stream<RegisterState>_mapPhoneChangedToState(String phone) async*{}

  Stream<RegisterState> _mapFormSubmitChangedToState(String email, String password, String name, String phone) async*{
    yield RegisterState.loading();
    try{
      await _userRepository.signUp(
        email: email,
        password: password,
        fullname: name,
        phone: phone
      );
      yield RegisterState.success();
    }catch(_){
      yield RegisterState.failure();
    }
  }

}