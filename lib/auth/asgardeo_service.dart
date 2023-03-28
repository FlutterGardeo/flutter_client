import 'dart:developer';

import 'package:flutter_appauth/flutter_appauth.dart';

import '../utils/auth_config_util.dart';
import '../utils/controller.dart';

class AuthController extends Controller {
  static const FlutterAppAuth _flutterAppAuth = FlutterAppAuth();

  static Future<AuthorizationTokenResponse?> loginAction() async {
    final String clientId = await AuthConfigUtil.getClientId();
    final List<String> scopes = await AuthConfigUtil.getScopes();
    final String discoveryUrl = await AuthConfigUtil.getDiscoveryUrl();

    try {
      final AuthorizationTokenResponse? result = await _flutterAppAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          clientId,
          AuthConfigUtil.getRedirectUrl(),
          discoveryUrl: discoveryUrl,
          scopes: scopes,
        ),
      );

      inspect(result);
      return result;
    } catch (e, s) {
      inspect("login error: $e - stack: $s");
      throw Exception("Failed to login");
    }
  }

  static Future<EndSessionResponse?> logoutAction(AuthorizationTokenResponse authorizationTokenResponse) async {
    final String discoveryUrl = await AuthConfigUtil.getDiscoveryUrl();
    try {
      final EndSessionResponse? result = await const FlutterAppAuth().endSession(
        EndSessionRequest(
          idTokenHint: AuthConfigUtil.getIdToken(authorizationTokenResponse),
          postLogoutRedirectUrl: AuthConfigUtil.getRedirectUrl(),
          discoveryUrl: discoveryUrl,
        ),
      );

      return result;
    } catch (e, s) {
      inspect("logout error: $e - stack: $s");
      throw Exception("Failed to logout");
    }
  }

  // static Future<String> getUserDetails(AuthorizationTokenResponse authorizationTokenResponse) async {

  //   final response = await http.get(
  //     Uri.parse(USER_INFO_URL),
  //     headers: {"Authorization": "Bearer $<ACCESS TOKEN>"},
  //   );

  //   if (response.statusCode == 200) {
  //     return jsonEncode(response.body);
  //   } else {
  //     throw Exception('Failed to get user details');
  //   }
  // }
}
