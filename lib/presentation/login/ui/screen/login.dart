import 'package:crypto_project_demo10_database/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:crypto_project_demo10_database/presentation/login/ui/items/loginCard.dart';

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
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
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
                LoginCard(userRepository: _userRepository),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
