part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class EventPressLogin extends LoginEvent {
  final String email;
  final String pass;

  EventPressLogin({required this.email, required this.pass});
}
