import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_client/config/constants.dart';
import 'package:flutter_client/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final auth = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        backgroundColor: kPrimaryColor,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  await auth.login();
                  if (auth.isAuthenticated) {
                    // if user,
                    if (true) {
                      Navigator.pushNamed(context, '/user');
                    } else {
                      // if admin
                      Navigator.pushNamed(context, '/admin');
                    }

                    // Save to local storage
                    // Save the access_token in app's SharedPreferences for later usage.
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('kfone_access_token', auth.accessToken);
                    prefs.setString('kfone_id_token', auth.authResponse!.idToken.toString());
                  }
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error.toString()),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await auth.logout();
                  if (!auth.isAuthenticated) {
                    Navigator.pushNamed(context, '/');
                  }
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error.toString()),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
