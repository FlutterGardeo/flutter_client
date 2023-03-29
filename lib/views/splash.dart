import 'package:flutter/material.dart';
import 'package:flutter_client/screens/initial_screen.dart';

import 'auth_checker.dart';

class Splash extends StatefulWidget {
  static const routeName = '/splash';
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Welcome to KFone app.. Loading..."),
      ),
    );
  }
}
