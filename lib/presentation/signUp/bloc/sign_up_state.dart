part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpSuccessState extends SignUpState{}

class SigningUpState extends SignUpState{}

class SignUpFailureState extends SignUpState{}

class SignUpValidateState extends SignUpState {
  final String? emptyEmail;
  final String? emptyPass;
  final String? invalidEmail;
  final String? invalidPass;
  final String? emptyName;
  final String? invalidName;
  final bool isEmptyEmail;
  final bool isEmptyPass;
  final bool isEmailInvalid;
  final bool isPassInvalid;
  final bool isEmptyName;
  final bool isNameInvalid;

  SignUpValidateState({
    required this.emptyEmail,
    required this.emptyPass,
    required this.invalidEmail,
    required this.invalidPass,
    required this.isEmptyEmail,
    required this.isEmptyPass,
    required this.isEmailInvalid,
    required this.isPassInvalid,
    required this.emptyName,
    required this.invalidName,
    required this.isEmptyName,
    required this.isNameInvalid,
  });
}
