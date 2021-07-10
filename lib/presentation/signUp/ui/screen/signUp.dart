import 'package:crypto_project_demo10_database/presentation/signUp/bloc/sign_up_bloc.dart';
import 'package:crypto_project_demo10_database/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:crypto_project_demo10_database/presentation/signUp/ui/items/signUpCard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatelessWidget {
  final UserRepository _userRepository;

  const SignUp({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg.png'),
              fit: BoxFit.cover,
            )),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Radity',
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontFamily: 'VNARIALB',
                      ),
                    ),
                    Text(
                      'Finance',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'VNARIALB',
                      ),
                    )
                  ],
                ),
              ),
              BlocProvider(
                create: (context) => SignUpBloc(userRepository: _userRepository),
                child: SignUpCard(userRepository: _userRepository),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
