import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super(props);
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthenticationState {
  final String displayEmail;
  final String displayName;

  Authenticated(this.displayEmail, this.displayName) : super([displayEmail]);

  @override
  String toString() =>
      'Authenticated { displayEmail: $displayEmail }{ displayName: $displayName}';
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}
