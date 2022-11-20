import 'package:flutter/material.dart';

import 'auth_card.dart';

class Login extends StatelessWidget{
  static const routeName = '/auth';
  const Login({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/avtlogin.png',
                width: 200,
                height: 200,
              ),
              
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text('Welcome to Cat MilkTea',
                  style: TextStyle(fontSize: 20,color: Color(0xFF00B906),fontWeight: FontWeight.w800 ),
                ),
              ),
              const Text('Please come with us. High quality delicious milk tea.',
                style: TextStyle(fontSize: 18,color: Color(0xFFA23DE0),fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: AuthCard(),
              ), 
            ],
          ),
        ),
      ),
    );
  }
}