import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_client/config/constants.dart';
import 'package:flutter_client/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final auth = Provider.of<AuthProvider>(context, listen: false);

    return FutureBuilder(
      future: auth.checkAuth(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while checking authentication status
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          // Authentication check is completed
          if (auth.isAuthenticated) {
            if (auth.getAuthorizedUser?.group == 'admin') {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(context, '/admin');
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(context, '/user');
              });
            }
            // Return an empty container since we're navigating away
            return Container();
          } else {
            // Show the login screen
            return Scaffold(
              backgroundColor: Color(0xffffcc80),
              appBar: AppBar(
                title: const Text('Login Screen'),
                backgroundColor: Colors.orange[400],
              ),
              body: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await auth.login();
                      if (auth.isAuthenticated) {
                        await auth.getUserDetails();
                        if (auth.getAuthorizedUser?.group == 'admin') {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.pushNamed(context, '/admin');
                          });
                        } else {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.pushNamed(context, '/user');
                          });
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
      },
    );
  }
}
