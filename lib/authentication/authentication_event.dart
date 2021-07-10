part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class EventStarted extends AuthenticationEvent{}
class EventLoggedIn extends AuthenticationEvent{}
class EventLoggedOut extends AuthenticationEvent{}
