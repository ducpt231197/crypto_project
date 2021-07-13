import 'dart:async';
import 'package:crypto_project_demo11_linechart/repositories/user_repository.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    String? emptyEmail;
    String? emptyPass;
    String? invalidEmail;
    String? invalidPass;
    bool isEmptyEmail = false;
    bool isEmptyPass = false;
    bool isEmailInvalid = false;
    bool isPassInvalid = false;
    bool isValid = true;
    if (event is EventPressLogin) {
      if (event.email.isEmpty) {
        emptyEmail = 'Please enter your email';
        isValid = false;
        isEmptyEmail = true;
        isEmailInvalid = true;
      } else if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(event.email)) {
        invalidEmail = 'Email is invalid';
        isValid = false;
        isEmailInvalid = true;
      }
      if (event.pass.isEmpty) {
        emptyPass = 'Please enter your password';
        isValid = false;
        isEmptyPass = true;
        isPassInvalid = true;
      } else if (event.pass.length < 6) {
        invalidPass = 'Password is invalid';
        isValid = false;
        isPassInvalid = true;
      }
      if (isValid) {
        try {
          yield LoggingInState();
          await _userRepository.signIn(event.email, event.pass);
          yield LoginSuccessState();
        } catch (e) {
          yield LoginFailureState();
        }
      } else {
        yield LoginValidateState(
          emptyEmail: emptyEmail,
          emptyPass: emptyPass,
          invalidEmail: invalidEmail,
          invalidPass: invalidPass,
          isEmptyEmail: isEmptyEmail,
          isEmptyPass: isEmptyPass,
          isEmailInvalid: isEmailInvalid,
          isPassInvalid: isPassInvalid,
        );
      }
    }
  }
}
