import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import "package:http/http.dart" as http;

import 'package:flutter_client/models/user.dart';

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
    try {
      result = await FlutterAppAuth().endSession(
        EndSessionRequest(
          idTokenHint: authResponse?.idToken,
          postLogoutRedirectUrl: dotenv.env['CALLBACK_URI']!,
          discoveryUrl: dotenv.env['DISCOVERY_URL']!,
        ),
      );
    } catch (e, s) {
      inspect("logout error: $e - stack: $s");
      throw Exception("Failed to logout");
    }
    _isAuthenticated = false;
    authResponse = null;
    notifyListeners();
  }

  Future<void> getUserDetails() async {
    final response = await http.get(
      Uri.parse(dotenv.env['USER_INFO_URL']!),
      headers: {"Authorization": "Bearer ${authResponse?.accessToken}"},
    );

    if (response.statusCode == 200) {
      final responseMap = jsonDecode(response.body);
      // print("Got user info");
      // print(response.statusCode);
      // print(response.body);
      // print("email");
      // print(jsonDecode(response.body)['email']);
      print(responseMap['email']);
      print(responseMap['given_name']);
      print(responseMap['family_name']);
      authorizedUser = User(
          email: responseMap['email'],
          firstName: responseMap['given_name'],
          lastName: responseMap['family_name']);
    } else {
      throw Exception('Failed to get user details');
    }
  }
}
