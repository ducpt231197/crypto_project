import 'package:crypto_project_demo11_linechart/presentation/signUp/bloc/sign_up_bloc.dart';
import 'package:crypto_project_demo11_linechart/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'raised_gradient_button.dart';
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
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if(state is SignUpSuccessState) {
          _showSnackBarSuccess(context);
        } else if(state is SignUpFailureState) {
          _showSnackBarFailure(context);
        }
      },
      child: BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(userRepository: _userRepository),
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, sigUpState) {
            if (sigUpState is SignUpValidateState) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Name textField
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: TextField(
                        controller: _textName,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Firstname',
                          prefixIcon: Icon(
                            Icons.account_circle_outlined,
                            color: sigUpState.isNameInvalid
                                ? Colors.red
                                : Colors.grey,
                          ),
                          errorText: sigUpState.isEmptyName
                              ? sigUpState.emptyName
                              : sigUpState.invalidName,
                        ),
                      ),
                    ),

                    //Email textField
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: TextField(
                        controller: _textEmail,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Email',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: sigUpState.isEmailInvalid
                                ? Colors.red
                                : Colors.grey,
                          ),
                          errorText: sigUpState.isEmptyEmail
                              ? sigUpState.emptyEmail
                              : sigUpState.invalidEmail,
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
                            color: sigUpState.isPassInvalid
                                ? Colors.red
                                : Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            onPressed: _toggle,
                            icon: Icon(_obscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                            color: sigUpState.isPassInvalid
                                ? Colors.red
                                : Colors.grey,
                          ),
                          errorText: sigUpState.isEmptyPass
                              ? sigUpState.emptyPass
                              : sigUpState.invalidPass,
                        ),
                      ),
                    ),

                    //SignUp Button
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: RaisedGradientButton(
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                gradient: const LinearGradient(
                                  colors: <Color>[
                                    Color(0xff02072f),
                                    Color(0xff0d1970)
                                  ],
                                ),
                                onPressed: () {
                                  setState(() {
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
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'I have an account already',
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      height: 30,
                    ),
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
                  //Name textField
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextField(
                      controller: _textName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Firstname',
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  //Email textField
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
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

                  //SignUp Button
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: RaisedGradientButton(
                              child: const Text(
                                'Sign Up',
                                style:
                                TextStyle(color: Colors.white, fontSize: 15),
                              ),
                              gradient: const LinearGradient(
                                colors: <Color>[
                                  Color(0xff02072f),
                                  Color(0xff0d1970)
                                ],
                              ),
                              onPressed: () {
                                setState(() {
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
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'I have an account already',
                              style:
                              TextStyle(decoration: TextDecoration.underline),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

void _showSnackBarFailure(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      backgroundColor: Colors.white,
      duration: Duration(seconds: 3),
      content: Text(
        'SignUpFail',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
}

void _showSnackBarSuccess(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      backgroundColor: Colors.white,
      duration: Duration(seconds: 3),
      content: Text(
        'SignUp Successful',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
}