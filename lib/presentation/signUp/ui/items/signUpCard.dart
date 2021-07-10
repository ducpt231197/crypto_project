
import 'package:crypto_project_demo10_database/presentation/signUp/bloc/sign_up_bloc.dart';
import 'package:crypto_project_demo10_database/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'raisedGradientButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCard extends StatefulWidget {
  final UserRepository _userRepository;

  const SignUpCard({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  _SignUpCardState createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> {
  bool _obscureText = true;
  final _textEmail = TextEditingController();
  final _textPass = TextEditingController();
  final _textName = TextEditingController();
  bool _emptyEmail = false;
  bool _emptyPass = false;
  bool _emptyName = false;
  late SignUpBloc _signUpBloc;

  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    // TODO: implement initState
    _signUpBloc = context.read<SignUpBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _textEmail.dispose();
    _textPass.dispose();
    _textName.dispose();
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
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(userRepository: _userRepository),
      child:
          BlocBuilder<SignUpBloc, SignUpState>(builder: (context, sigUpState) {
        if (sigUpState is SignUpFailureState) {
          print('SignUp Failed');
        } else if (sigUpState is SigningUpState) {
          print('SignUp in progress...');
        } else if (sigUpState is SignUpSuccessState) {
          print('SignUp Successfully');
        }
        return Container(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Name textField
                Container(
                  height: screenHeight < 750 ? 75 : 79,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    controller: _textName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Firstname',
                      prefixIcon: Icon(
                        Icons.account_circle_outlined,
                        color: _emptyName ? Colors.red : Colors.blue,
                      ),
                      errorText: _emptyName ? "Please fill in the blank" : null,
                    ),
                  ),
                ),

                //Email textField
                Container(
                  height: screenHeight < 750 ? 65 : 69,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: TextField(
                    controller: _textEmail,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: _emptyEmail ? Colors.red : Colors.blue,
                      ),
                      errorText:
                          _emptyEmail ? "Please fill in the blank" : null,
                    ),
                  ),
                ),

                //Password textField
                Container(
                  height: screenHeight < 750 ? 65 : 69,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: TextField(
                    controller: _textPass,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: _emptyPass ? Colors.red : Colors.blue,
                      ),
                      errorText: _emptyPass ? "Password is empty" : null,
                      suffixIcon: IconButton(
                        onPressed: _toggle,
                        icon: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                        color: _emptyPass ? Colors.red : Colors.blue,
                      ),
                    ),
                  ),
                ),

                //SignUp Button
                Container(
                  height: screenHeight < 750 ? 40 : 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: RaisedGradientButton(
                            child: Text(
                              'Sign Up',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xff02072f),
                                Color(0xff0d1970)
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                _textName.text.isEmpty
                                    ? _emptyName = true
                                    : _emptyName = false;
                                _textEmail.text.isEmpty
                                    ? _emptyEmail = true
                                    : _emptyEmail = false;
                                _textPass.text.isEmpty
                                    ? _emptyPass = true
                                    : _emptyPass = false;
                                _signUpBloc.add(
                                  EventPressSignUp(
                                    email: _textEmail.text,
                                    pass: _textPass.text,
                                    name: _textName.text,
                                  ),
                                );
                              });
                            }),
                      ),
                    ],
                  ),
                ),

                //SignIn textButton
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'I have an account already',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          )),
                    ],
                  ),
                ),
                Container(
                  height: screenHeight < 750 ? 0 : 30,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
