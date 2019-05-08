import 'package:bloc/bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  void onTransition(Bloc bloc, Transition transition) => null;

  void onError(Bloc bloc, Object error, StackTrace stacktrace) => null;
}
