import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_client/auth/asgardeo_service.dart';
import 'package:flutter_client/views/dashboard.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_view_model.dart';
import '../providers/user_provider.dart';
import '../services/flutter_app_auth.dart';

class AuthorizationPage extends StatefulHookWidget {
  static const routeName = '/auth-page';

  AuthorizationPage({Key? key}) : super(key: key);
  AuthorizationTokenResponse? tokenResponse = null;

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
    final _currentUserProvider = useProvider(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Initial Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // // handle sign in button press
                // // TODO

                // tokenResponse = await AuthController.loginAction();
                // String _result = jsonEncode(tokenResponse!.toString());
                // SharedPreferences prefs = await SharedPreferences.getInstance();
                // prefs.setString("user", _result);

                // _currentUserProvider.state = UserViewModel(
                //   id: tokenResponse!.idToken.toString(),
                //   userName: tokenResponse!.accessToken.toString(),
                // );

                // // TODO
                // Navigator.pushNamedAndRemoveUntil(context, Dashboard.routeName, (route) => false);
              },
              child: Text('Sign in'),
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
