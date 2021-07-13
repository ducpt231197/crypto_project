import 'package:crypto_project_demo11_linechart/authentication/authentication_bloc.dart';
import 'package:crypto_project_demo11_linechart/presentation/login/bloc/login_bloc.dart';
import 'package:crypto_project_demo11_linechart/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'raised_gradient_button.dart';
import 'package:crypto_project_demo11_linechart/presentation/signUp/ui/screen/sign_up.dart';

class LoginCard extends StatefulWidget {
  final UserRepository _userRepository;

  const LoginCard({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  bool _obscureText = true;
  final _textEmail = TextEditingController();
  final _textPass = TextEditingController();
  late LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    // TODO: implement initState
    _loginBloc = context.read<LoginBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _textEmail.dispose();
    _textPass.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, loginStage) {
        if (loginStage is LoginSuccessState) {
          BlocProvider.of<AuthenticationBloc>(context).add(EventLoggedIn());
        }
      },
      builder: (context, loginStage) {
        if (loginStage is LoginValidateState) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Email textField
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: TextField(
                    controller: _textEmail,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Email',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: loginStage.isEmailInvalid ? Colors.red : Colors.grey,
                      ),
                      errorText: loginStage.isEmptyEmail
                          ? loginStage.emptyEmail
                          : loginStage.invalidEmail,
                    ),
                  ),
                ),

                //Password textField
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: TextField(
                    controller: _textPass,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: loginStage.isPassInvalid ? Colors.red : Colors.grey,
                      ),
                      suffixIcon: IconButton(
                        onPressed: _toggle,
                        icon: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                        color: loginStage.isPassInvalid ? Colors.red : Colors.grey,
                      ),
                      errorText: loginStage.isEmptyPass
                          ? loginStage.emptyPass
                          : loginStage.invalidPass,
                    ),
                  ),
                ),

                //Login Button
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Expanded(
                    child: RaisedGradientButton(
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        gradient: const LinearGradient(
                          colors: <Color>[
                            Color(0xff02072f),
                            Color(0xff0d1970)
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            _loginBloc.add(
                              EventPressLogin(
                                email: _textEmail.text,
                                pass: _textPass.text,
                              ),
                            );
                          });
                        }),
                  ),
                ),

                //textButton
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Forgot password textButton
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            )),
                        const VerticalDivider(
                          color: Colors.grey,
                          width: 30,
                          thickness: 0.4,
                          indent: 15,
                          endIndent: 15,
                        ),

                        //SignUp textButton
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp(
                                        userRepository: _userRepository)),
                              );
                            },
                            child: const Text(
                              'Create an Account',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 30,
                )
              ],
            ),
          );
        }
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Email textField
              Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: TextField(
                  controller: _textEmail,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              //Password textField
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: TextField(
                  controller: _textPass,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Password',
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      onPressed: _toggle,
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              //Login Button
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Expanded(
                  child: RaisedGradientButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      gradient: const LinearGradient(
                        colors: <Color>[Color(0xff02072f), Color(0xff0d1970)],
                      ),
                      onPressed: () {
                        setState(() {
                          _loginBloc.add(
                            EventPressLogin(
                              email: _textEmail.text,
                              pass: _textPass.text,
                            ),
                          );
                        });
                      }),
                ),
              ),

              //textButton
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Forgot password textButton
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                                decoration: TextDecoration.underline),
                          )),
                      const VerticalDivider(
                        color: Colors.grey,
                        width: 30,
                        thickness: 0.4,
                        indent: 15,
                        endIndent: 15,
                      ),

                      //SignUp textButton
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp(
                                      userRepository: _userRepository)),
                            );
                          },
                          child: const Text(
                            'Create an Account',
                            style: TextStyle(
                                decoration: TextDecoration.underline),
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                height: 30,
              )
            ],
          ),
        );
      },
    );
  }
}
