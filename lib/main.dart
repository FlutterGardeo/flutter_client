import 'package:flutter/material.dart';
import 'package:flutter_client/screens/devices_services_screen.dart';
import 'package:provider/provider.dart';

import 'package:flutter_client/services/auth_service.dart';
import 'package:flutter_client/screens/initial_screen.dart';
import 'package:flutter_client/config/constants.dart';
import 'package:flutter_client/screens/admin_portal_screen.dart';
import 'package:flutter_client/screens/user_portal_screen.dart';
import 'package:flutter_client/screens/splash_screen.dart';

void main() {
  runApp(KFoneClient());
}

class KFoneClient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          accentColor: kPrimaryColor,
          scaffoldBackgroundColor: kSecondaryColor,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kPrimaryColor),
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/devices-and-services': (context) => DevicesAndServices(),
          '/user': (context) => Consumer<AuthProvider>(
                builder: (context, auth, _) {
                  if (auth.isAuthenticated) {
                    print("User: ${auth.tokenResponse?.refreshToken}");
                    print(auth.tokenResponse?.refreshToken.runtimeType);
                    auth.saveAccessToken();
                    return UserPortal();
                  } else {
                    return LoginScreen();
                  }
                },
              ),
          '/admin': (context) => Consumer<AuthProvider>(
                builder: (context, auth, _) {
                  if (auth.isAuthenticated) {
                    print("Admin: ${auth.tokenResponse?.refreshToken}");
                    auth.saveAccessToken();
                    return AdminPortal();
                  } else {
                    return LoginScreen();
                  }
                },
              ),
        },
      ),
    );
  }
}
