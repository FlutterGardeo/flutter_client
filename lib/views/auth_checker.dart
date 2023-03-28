import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_client/views/auth.dart';
import 'package:flutter_client/views/dashboard.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/user_provider.dart';

class AuthChecker extends StatefulHookWidget {
  static const routeName = '/auth-checker';

  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  String? user;

  Future<AuthorizationTokenResponse?> getLocalUser() async {
    // TODO-get user from shared prefs.
    user = "";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get("user") as AuthorizationTokenResponse?;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _currentUserProvider = useProvider(currentUserProvider);
    //TODO-add auth check here.

    // If user state is filled with valid id (user found in SharedPreferences, go to dashboard.))
    if (_currentUserProvider.state.id != null) {
      return const Dashboard();
    }
    return AuthorizationPage();
  }
}
