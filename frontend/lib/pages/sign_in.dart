import 'package:flutter/material.dart';
import 'package:frontend/pages/home.dart';
import 'package:frontend/services/initializer.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          Initializer.initialize(context);

          Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=> const HomePage()));
        },
        child: const Text('Sign In'),
      ))
    );
  }
}
