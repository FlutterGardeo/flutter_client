import 'package:flutter/material.dart';
import 'package:flutter_client/screens/admin_portal_screen.dart';
import 'package:flutter_client/screens/initial_screen.dart';
import 'package:flutter_client/screens/user_portal_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_view_model.dart';
import '../services/auth_service.dart';

class AuthChecker extends StatefulWidget {
  static const routeName = '/';

  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  // String? user;
  UserViewModel? user;

  void getLocalData() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String at = prefs.getString('kfone_access_token') ?? "";
    prefs.getString('kfone_id_token');

    auth.validateAccessToken(at);
  }

  @override
  void initState() {
    super.initState();

    getLocalData();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);

    print('authentc ? ${auth.isAuthenticated}');

    if (auth.isAuthenticated) {
      print('querying user updated');
      if (true) {
        // if user,
        return UserPortal();
      } else if (true) {
        return AdminPortal();
      }
    }

    return LoginScreen();
  }
}
