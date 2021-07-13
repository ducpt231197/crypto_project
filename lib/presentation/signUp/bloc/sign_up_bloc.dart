import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_project_demo11_linechart/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    String? emptyEmail;
    String? emptyPass;
    String? invalidEmail;
    String? invalidPass;
    String? emptyName;
    String? invalidName;
    bool isEmptyEmail = false;
    bool isEmptyPass = false;
    bool isEmailInvalid = false;
    bool isPassInvalid = false;
    bool isEmptyName = false;
    bool isNameInvalid = false;
    bool isValid = true;

    if (event is EventPressSignUp) {
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
      } if (event.name.isEmpty) {
        emptyName = 'Please enter your name';
        isValid = false;
        isEmptyName = true;
        isNameInvalid = true;
      } else if (event.pass.length < 2) {
        invalidName = 'Name is invalid';
        isValid = false;
        isNameInvalid = true;
      }
      if (isValid) {
        yield SigningUpState();
        try {
          await _userRepository.signUp(
            name: event.name,
            email: event.email,
            password: event.pass,
          );
          yield SignUpSuccessState();
        } catch (e) {
          yield SignUpFailureState();
        }
      } else {
        yield SignUpValidateState(
          emptyEmail: emptyEmail,
          emptyPass: emptyPass,
          invalidEmail: invalidEmail,
          invalidPass: invalidPass,
          isEmptyEmail: isEmptyEmail,
          isEmptyPass: isEmptyPass,
          isEmailInvalid: isEmailInvalid,
          isPassInvalid: isPassInvalid,
          emptyName: emptyName,
          invalidName: invalidName,
          isEmptyName: isEmptyName,
          isNameInvalid: isNameInvalid,
        );
      }
    }
  }
}
