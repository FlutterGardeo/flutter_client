import 'package:flutter/material.dart';
import 'package:flutter_client/views/auth.dart';
import 'package:flutter_client/views/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        AuthorizationPage.routeName: (context) => const AuthorizationPage(),
        Dashboard.routeName: (context) => const Dashboard(),
      },
    );
  }
}
