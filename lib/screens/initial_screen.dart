import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_client/config/constants.dart';
import 'package:flutter_client/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/';
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
                    await auth.getUserDetails();
                    if (auth.getAuthorizedUser?.lastName != null) {
                      print("Admin User");
                      Navigator.pushNamed(context, '/admin');
                    } else {
                      print("NOT Admin User");
                      Navigator.pushNamed(context, '/user');
                    }

                    // Save to local storage
                    // Save the user details in app's SharedPreferences for later usage.
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    String jsonUser = jsonEncode((await auth.getUserDetails()).toJson());
                    prefs.setString('kfone_user', jsonUser);
                    log('access token: ${auth.authResponse?.accessToken}');
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
            // ElevatedButton(
            //   onPressed: () async {
            //     try {
            //       await auth.logout();
            //       if (!auth.isAuthenticated) {
            //         Navigator.pushNamed(context, '/');
            //       }
            //     } catch (error) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content: Text(error.toString()),
            //           duration: const Duration(seconds: 3),
            //         ),
            //       );
            //     }
            //   },
            //   child: const Text('Logout'),
            // ),
          ],
        ),
      ),
    );
  }
}
