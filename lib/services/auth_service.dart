import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_client/models/user_view_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import "package:http/http.dart" as http;

import 'package:flutter_client/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  AuthorizationTokenResponse? authResponse;
  EndSessionResponse? result;
  User? authorizedUser;

  bool _isAuthenticated = false;
  bool _isLoading = false;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  User? get getAuthorizedUser => authorizedUser;

  Future<void> login() async {
    try {
      _isLoading = true;
      notifyListeners();

      await dotenv.load();

      authResponse = await const FlutterAppAuth().authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          dotenv.env['CLIENT_ID']!,
          dotenv.env['CALLBACK_URI']!,
          discoveryUrl: dotenv.env['DISCOVERY_URL']!,
          scopes: ["openid", "email", "profile", "groups" "internal_login"],
        ),
      );

      if (authResponse != null) {
        _isAuthenticated = true;
        notifyListeners();
      }
    } catch (e, s) {
      inspect("login error: $e - stack: $s");
      print("login error: $e");
      print("stack: $s");
      throw Exception("Failed to login");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('kfone_id_token'));

    try {
      result = await FlutterAppAuth().endSession(
        EndSessionRequest(
            // idTokenHint: authResponse?.idToken,
            idTokenHint: prefs.getString('kfone_id_token'),
            postLogoutRedirectUrl: 'com.wso2.kfonelk://login-callback',
            discoveryUrl: 'https://api.asgardeo.io/t/kfonelk/oauth2/token/.well-known/openid-configuration'),
      );
    } catch (e, s) {
      print(e);
      inspect("logout error: $e - stack: $s");
      throw Exception("Failed to logout");
    }
    _isAuthenticated = false;
    authResponse = null;
    prefs.setString('kfone_access_token', "");
    prefs.setString('kfone_id_token', "");
    notifyListeners();
  }

  Future<UserViewModel> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(
      // Uri.parse(dotenv.env['USER_INFO_URL']!),
      Uri.parse('https://api.asgardeo.io/t/kfonelk/oauth2/userinfo'),
      // headers: {"Authorization": "Bearer ${authResponse?.accessToken}"},
      headers: {"Authorization": "Bearer ${prefs.get('kfone_access_token')}"},
    );

    if (response.statusCode == 200) {
      final responseMap = jsonDecode(response.body);
      print(responseMap['email']);
      print(responseMap['given_name']);
      print(responseMap['family_name']);
      authorizedUser = User(email: responseMap['email'], firstName: responseMap['given_name'], lastName: responseMap['family_name']);

      return UserViewModel.fromJson({
        "email": responseMap['email'],
        "firstName": responseMap['given_name'],
        "lastName": responseMap['family_name'],
        "accessToken": authResponse?.accessToken,
      });
    } else {
      throw Exception('Failed to get user details');
    }

    notifyListeners();
  }

  String get accessToken => authResponse?.accessToken ?? "";

  Future<bool> validateAccessToken(String token) async {
    final endpoint = 'https://api.asgardeo.io/t/kfonelk/oauth2/introspect';

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Basic eUttTlVfemRYV2kyaTd6RXdEbnN1Q3ljS0pnYTpaSFlQNkNzSW93ckFDYjJkMU8xU2pxSm45TlVh'},
      body: {'token': token},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to check access token');
    }

    final jsonResponse = jsonDecode(response.body);
    _isAuthenticated = jsonResponse['active'] ?? false;
    notifyListeners();
    return _isAuthenticated;
  }
}
