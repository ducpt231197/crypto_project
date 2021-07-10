part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class Initial extends AuthenticationState{}

class Success extends AuthenticationState{
  final User? firebaseUser;
  Success({required this.firebaseUser});
}

class Failure extends AuthenticationState{}
