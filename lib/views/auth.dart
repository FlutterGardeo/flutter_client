import 'package:flutter/material.dart';

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authorization'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // handle sign in button press
              },
              child: Text('Sign in'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                // handle sign up button press
              },
              child: const Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
