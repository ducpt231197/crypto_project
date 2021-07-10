part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoggingInState extends LoginState {}

class LoginFailureState extends LoginState {}

class LoginValidateState extends LoginState {
  final String? emptyEmail;
  final String? emptyPass;
  final String? invalidEmail;
  final String? invalidPass;
  final bool isEmptyEmail;
  final bool isEmptyPass;
  final bool isEmailInvalid;
  final bool isPassInvalid;

  LoginValidateState({
    required this.emptyEmail,
    required this.emptyPass,
    required this.invalidEmail,
    required this.invalidPass,
    required this.isEmptyEmail,
    required this.isEmptyPass,
    required this.isEmailInvalid,
    required this.isPassInvalid,
  });
}
