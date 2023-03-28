import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_client/config/constants.dart';
import 'package:flutter_client/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
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
        child: ElevatedButton(
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
      ),
    );
  }
}
