import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
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
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'www.radity.com',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
