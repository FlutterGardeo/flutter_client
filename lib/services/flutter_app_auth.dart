import 'dart:async';
import 'dart:developer';

import 'package:flutter_appauth/flutter_appauth.dart';

class AppAuthService {
  final FlutterAppAuth _appAuth = FlutterAppAuth();

  Future<AuthorizationTokenResponse?> authorizeAndExchangeCode() async {
    try {
      final AuthorizationTokenResponse? result =
          await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          'CupfurPk3WnXKtKTPu_elhf68oYa',
          'com.wso2.exampleorg://login-callback',
          discoveryUrl:
              'https://api.asgardeo.io/t/exampleorg/oauth2/token/.well-known/openid-configuration',
          scopes: ["openid", "email", "profile", "internal_login"],
        ),
      );

      return result;
    } catch (e, s) {
      inspect("logout error: $e - stack: $s");
      throw Exception('Failed to login');
    }
  }

  // Future<EndSessionResponse?> logoutAction(
  //     AuthorizationTokenResponse authorizationTokenResponse) async {
  //   try {
  //     final EndSessionResponse? result = await FlutterAppAuth().endSession(
  //       EndSessionRequest(
  //         idTokenHint: _authResponse!.accessToken,
  //         postLogoutRedirectUrl: 'com.wso2.exampleorg://login-callback',
  //         discoveryUrl:
  //             'https://api.asgardeo.io/t/exampleorg/oauth2/token/.well-known/openid-configuration',
  //       ),
  //     );

  //     return result;
  //   } catch (e, s) {
  //     inspect("logout error: $e - stack: $s");
  //     throw Exception("Failed to logout");
  //   }
  // }
}
