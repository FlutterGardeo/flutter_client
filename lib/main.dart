import 'package:flutter/material.dart';
import 'package:flutter_client/views/auth.dart';
import 'package:flutter_client/views/splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'views/auth_checker.dart';
import 'views/dashboard.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
      home: const Splash(),
      routes: {
        Splash.routeName: (context) => const Splash(),
        AuthorizationPage.routeName: (context) => AuthorizationPage(),
        AuthChecker.routeName: (context) => const AuthChecker(),
        Dashboard.routeName: (context) =>  Dashboard(),
      },
    );
  }
}
