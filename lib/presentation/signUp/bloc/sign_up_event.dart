part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class EventPressSignUp extends SignUpEvent {
  final String email;
  final String pass;
  final String name;

  EventPressSignUp({required this.email, required this.pass, required this.name});
}