import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

import 'package:flutter_client/services/flutter_app_auth.dart';

class AuthorizationPage extends StatefulWidget {
  static const routeName = "/";

  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  final AppAuthService _authService = AppAuthService();
  AuthorizationTokenResponse? _authResponse;

  Future<void> _handleLogin() async {
    final result = await _authService.authorizeAndExchangeCode();

    if (result != null) {
      setState(() {
        _authResponse = result;
      });

      Navigator.pushNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Initial Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Click the button to login',
            ),
            ElevatedButton(
              onPressed: _handleLogin,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
