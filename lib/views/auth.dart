import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_client/views/dashboard.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_view_model.dart';
import '../providers/user_provider.dart';
import '../services/flutter_app_auth.dart';

class AuthorizationPage extends StatefulHookWidget {
  static const routeName = '/auth-page';

  AuthorizationPage({Key? key}) : super(key: key);
  AuthorizationTokenResponse? tokenResponse = null;

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
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

      // Update state
      Map<String, dynamic> payload = Jwt.parseJwt(_authResponse!.idToken.toString());
      UserViewModel user = UserViewModel.fromJson(payload);

      // Update the user details in the provider for state.
      context.read(currentUserProvider).state = user;

      // Save the user details in app's SharedPreferences for later usage.
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonUser = jsonEncode(user.toJson());
      prefs.setString('kfone_user', jsonUser);
      Navigator.pushNamedAndRemoveUntil(context, Dashboard.routeName, (route) => false);
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
              onPressed: _handleLogin,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
