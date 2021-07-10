import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_project_demo10_database/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent signUpEvent) async* {
    if (signUpEvent is EventPressSignUp) {
      yield SigningUpState();
      try {
        await _userRepository.signUp(
          name: signUpEvent.name,
          email: signUpEvent.email,
          password: signUpEvent.pass,
        );
        yield SignUpSuccessState();
      } catch (e) {
        yield SignUpFailureState();
      }
    }
  }
}
