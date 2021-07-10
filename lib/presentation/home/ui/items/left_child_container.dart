import 'package:crypto_project_demo10_database/authentication/authentication_bloc.dart';
import 'package:crypto_project_demo10_database/presentation/favorite/ui/screen/favorite_screen.dart';
import 'package:crypto_project_demo10_database/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeftChildContainer extends StatefulWidget {
  @override
  _LeftChildContainerState createState() => _LeftChildContainerState();
}

class _LeftChildContainerState extends State<LeftChildContainer> {
  String name = FirebaseAuth.instance.currentUser!.displayName.toString();
  final UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff070f51),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            alignment: Alignment.topCenter,
            child: const Text(
              'More',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(width: 30),
                    const SizedBox(
                      height: 40,
                      width: 40,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/avata.jpg'),
                        radius: 20,
                      ),
                    ),
                    Container(width: 20),
                    Text(
                      "$name's profile",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),
                    )
                  ],
                ),
                Container(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => FavoriteScreen()));
                  },
                  child: Row(
                    children: [
                      Container(width: 30),
                      const SizedBox(
                        height: 40,
                        width: 40,
                        child: Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      Container(width: 20),
                      const Text(
                        'Favorites',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),
                      )
                    ],
                  ),
                ),
                Container(height: 20),
                Row(
                  children: [
                    Container(width: 30),
                    const SizedBox(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.store,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    Container(width: 20),
                    const Text(
                      'Market',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),
                    )
                  ],
                ),
                Container(height: 20),
                Row(
                  children: [
                    Container(width: 30),
                    const SizedBox(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.text_snippet,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Container(width: 20),
                    const Text(
                      'News',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),
                    )
                  ],
                ),
                Container(height: 20),
                Row(
                  children: [
                    Container(width: 30),
                    const SizedBox(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.upgrade,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Container(width: 20),
                    const Text(
                      'Upgrade',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),
                    )
                  ],
                ),
                const Divider(
                  height: 40,
                  color: Colors.grey,
                  thickness: 0.4,
                  indent: 25,
                  endIndent: 100,
                ),
                Row(
                  children: [
                    Container(width: 30),
                    const SizedBox(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Container(width: 20),
                    const Text(
                      'Setting',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),
                    )
                  ],
                ),
                Container(height: 20),
                Row(
                  children: [
                    Container(width: 30),
                    const SizedBox(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Container(width: 20),
                    const Text(
                      'Private',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),
                    )
                  ],
                ),
                Container(height: 20),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          AlertDialog(
                            title: const Text('Logout ?'),
                            content: const Text('Do you want to logout?'),
                            actions: [
                              TextButton(
                                child: const Text('Stay'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Logout'),
                                onPressed: () {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(EventLoggedOut());
                                },
                              ),
                            ],
                          ),
                    );
                  },
                  // onTap: () {
                  //   BlocProvider.of<AuthenticationBloc>(context)
                  //       .add(EventLoggedOut());
                  // },
                  child: Row(
                    children: [
                      Container(width: 30),
                      const SizedBox(
                        height: 40,
                        width: 40,
                        child: Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Container(width: 20),
                      const Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
