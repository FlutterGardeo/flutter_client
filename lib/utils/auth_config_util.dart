import 'package:flutter_appauth/flutter_appauth.dart';

import 'common.dart';

abstract class AuthConfigUtil {
  static const String _redirectUrl = "com.example.flutterclient://login-callback";

  static Future<Map<String, dynamic>> _readConfigJson() async {
    // TODO
    // Add authorization config here

    final String config = """""";
    final Map<String, dynamic> configJson = Common.jsonDecode(config);

    return configJson;
  }

  /// get the base organization url
  static Future<String> getBaseOrganizationUrl() async {
    final Map<String, dynamic> configJson = await _readConfigJson();

    return configJson["AuthorizationConfig"]["BaseOrganizationUrl"];
  }

  /// get the client id
  static Future<String> getClientId() async {
    final Map<String, dynamic> configJson = await _readConfigJson();

    return configJson["AuthorizationConfig"]["ClientId"];
  }

  /// get the client secret
  static Future<String> getClientSecret() async {
    final Map<String, dynamic> configJson = await _readConfigJson();

    return configJson["AuthorizationConfig"]["ClientSecret"];
  }

  /// get the client secret
  static Future<List<String>> getScopes() async {
    final Map<String, dynamic> configJson = await _readConfigJson();

    return List<String>.from(configJson["AuthorizationConfig"]["Scopes"]);
  }

  /// get the redirect url
  static String getRedirectUrl() {
    return _redirectUrl;
  }

  /// get the discovery url
  static Future<String> getDiscoveryUrl() async {
    String baseUrl = await getBaseOrganizationUrl();

    return "$baseUrl/oauth2/token/.well-known/openid-configuration";
  }

  /// get the logout url
  static Future<String> getLogoutUrl() async {
    String baseUrl = await getBaseOrganizationUrl();

    return "$baseUrl/oidc/logout";
  }

  /// get the access token from the `AuthorizationTokenResponse`
  static String getAccessToken(AuthorizationTokenResponse authorizationTokenResponse) {
    String? accessToken = authorizationTokenResponse.accessToken;

    if (accessToken == null) {
      return "";
    }

    return accessToken;
  }

  /// get the ID token from the `AuthorizationTokenResponse`
  static String getIdToken(AuthorizationTokenResponse authorizationTokenResponse) {
    String? idToken = authorizationTokenResponse.idToken;

    if (idToken == null) {
      return "";
    }

    return idToken;
  }
}
