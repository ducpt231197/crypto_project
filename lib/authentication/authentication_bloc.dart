import 'dart:async';

import 'package:crypto_project_demo11_linechart/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  AuthenticationBloc({required UserRepository userRepository}) :
        _userRepository = userRepository,
        super(Initial());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async*{
    if(event is EventStarted) {
      final isSignedIn = await _userRepository.isSignIn();
      if(isSignedIn) {
        final user = await _userRepository.getUser();
        yield Success(firebaseUser: user);
      } else {
        yield Failure();
      }
    }else if (event is EventLoggedIn) {
      yield Success(firebaseUser: await _userRepository.getUser());
    }else if (event is EventLoggedOut) {
      _userRepository.signOut();
      yield Failure();
    }
  }
}
