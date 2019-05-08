import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class NameChanged extends RegisterEvent{
  final String name;
  NameChanged({@required this.name}) :super([name]);

  @override
  String toString() => 'NameChanged { name: $name }';
}

class PhoneChanged extends RegisterEvent{
  final String phone;
  PhoneChanged({@required this.phone}) : super([phone]);

  @override
  String toString() => 'PhoneChanged { phone: $phone }';
}

class Submitted extends RegisterEvent {
  final String email;
  final String password;
  final String name;
  final String phone;

  Submitted({@required this.email, @required this.password, @required this.name, @required this.phone})
      : super([email, password, name, phone]);

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password, name: $name, phone: $phone }';
  }
}