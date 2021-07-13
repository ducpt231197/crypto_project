import 'package:crypto_project_demo11_linechart/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:crypto_project_demo11_linechart/presentation/login/ui/items/login_card.dart';

class Login extends StatelessWidget {
  final UserRepository _userRepository;

  const Login({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          decoration: const BoxDecoration(
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
                      const Text(
                        'Radity',
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                          fontFamily: 'VNARIALB',
                        ),
                      ),
                      const Text(
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
                LoginCard(userRepository: _userRepository),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
