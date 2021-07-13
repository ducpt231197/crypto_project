import 'package:crypto_project_demo11_linechart/presentation/home/ui/screen/home.dart';
import 'package:crypto_project_demo11_linechart/presentation/splash.dart';
import 'package:crypto_project_demo11_linechart/repositories/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:crypto_project_demo11_linechart/presentation/login/ui/screen/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication/authentication_bloc.dart';
import 'presentation/login/bloc/login_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    final UserRepository _userRepository = UserRepository();
    return MaterialApp(

      title: 'Crypto finance',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: BlocProvider(
        create: (context) {
          final authenticationBloc =
          AuthenticationBloc(userRepository: _userRepository);
          authenticationBloc.add(EventStarted());
          return authenticationBloc;
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authenticationStage) {
            if (authenticationStage is Success) {
              return HomeScreen();
            } else if (authenticationStage is Failure) {
              return BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(userRepository: _userRepository),
                child: Login(userRepository: _userRepository),
              );
            }
            return Splash();
          },
        ),
      ),
    );
  }
}
