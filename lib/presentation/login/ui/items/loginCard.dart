import 'package:crypto_project_demo10_database/authentication/authentication_bloc.dart';
import 'package:crypto_project_demo10_database/presentation/login/bloc/login_bloc.dart';
import 'package:crypto_project_demo10_database/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'raisedGradientButton.dart';
import 'package:crypto_project_demo10_database/presentation/signUp/ui/screen/signUp.dart';

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
    int screenHeight = MediaQuery.of(context).size.height.toInt();
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, loginStage) {
        if (loginStage is LoginSuccessState) {
          print('logged in');
          BlocProvider.of<AuthenticationBloc>(context).add(EventLoggedIn());
        }
      },
      builder: (context, loginStage) {
        if (loginStage is LoginValidateState) {
          return Container(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Email textField
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: TextField(
                      controller: _textEmail,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
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
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: TextField(
                      controller: _textPass,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
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
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Expanded(
                      child: RaisedGradientButton(
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          gradient: LinearGradient(
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
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Forgot password textButton
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password',
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              )),
                          VerticalDivider(
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
                              child: Text(
                                'Create an Account',
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: screenHeight < 750 ? 0 : 30,
                  )
                ],
              ),
            ),
          );
        }
        return Container(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Email textField
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: TextField(
                    controller: _textEmail,
                    decoration: InputDecoration(
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
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: TextField(
                    controller: _textPass,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                      prefixIcon: Icon(
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
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Expanded(
                    child: RaisedGradientButton(
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        gradient: LinearGradient(
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
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Forgot password textButton
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            )),
                        VerticalDivider(
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
                            child: Text(
                              'Create an Account',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: screenHeight < 750 ? 0 : 30,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
