import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import "package:http/http.dart" as http;

import 'package:flutter_client/models/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  AuthorizationResponse? authResponse;
  EndSessionResponse? endSessionResponse;
  SharedPreferences? prefs;
  TokenResponse? tokenResponse;
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

      authResponse = await const FlutterAppAuth().authorize(
        AuthorizationRequest(
          dotenv.env['CLIENT_ID']!,
          dotenv.env['CALLBACK_URI']!,
          discoveryUrl: dotenv.env['DISCOVERY_URL']!,
          scopes: dotenv.env['SCOPES']?.split(","),
        ),
      );

      if (authResponse != null && authResponse?.authorizationCode != null) {
        tokenResponse = await const FlutterAppAuth().token(TokenRequest(
          dotenv.env['CLIENT_ID']!,
          dotenv.env['CALLBACK_URI']!,
          authorizationCode: authResponse?.authorizationCode,
          discoveryUrl: dotenv.env['DISCOVERY_URL']!,
          codeVerifier: authResponse?.codeVerifier,
          nonce: authResponse?.nonce,
          scopes: dotenv.env['SCOPES']?.split(","),
        ));

        if (tokenResponse != null) {
          print("Refresh Token: ${tokenResponse?.refreshToken}");
          print(tokenResponse?.refreshToken.runtimeType);
          _isAuthenticated = true;
          notifyListeners();
        }
      }
    } catch (e, s) {
      inspect("login error: $e - stack: $s");
      throw Exception("Failed to login");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      _isLoading = true;
      notifyListeners();

      endSessionResponse = await const FlutterAppAuth().endSession(
        EndSessionRequest(
          idTokenHint: tokenResponse?.idToken,
          postLogoutRedirectUrl: dotenv.env['CALLBACK_URI']!,
          discoveryUrl: dotenv.env['DISCOVERY_URL']!,
        ),
      );

      if (endSessionResponse != null) {
        prefs = await SharedPreferences.getInstance();
        prefs?.remove('kfone_refresh_token');

        _isAuthenticated = false;
        authResponse = null;
        notifyListeners();
      }
    } catch (e, s) {
      inspect("Logout Error: $e - stack: $s");
      throw Exception("Failed to logout");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshAccessToken(String refreshToken) async {
    try {
      _isLoading = true;
      notifyListeners();

      await dotenv.load();

      if (await validateToken(refreshToken)) {
        tokenResponse = await const FlutterAppAuth().token(TokenRequest(
          dotenv.env['CLIENT_ID']!,
          dotenv.env['CALLBACK_URI']!,
          discoveryUrl: dotenv.env['DISCOVERY_URL']!,
          refreshToken: refreshToken,
          scopes: dotenv.env['SCOPES']?.split(","),
        ));
      }

      print("Not Valid");
    } catch (e, s) {
      inspect("Refresh Token Error: $e - stack: $s");
      throw Exception("Failed to refresh access token");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getUserDetails() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await http.get(
        Uri.parse(dotenv.env['USER_INFO_URL']!),
        headers: {"Authorization": "Bearer ${tokenResponse?.accessToken}"},
      );

      if (response.statusCode == 200) {
        final responseMap = jsonDecode(response.body);
        authorizedUser = User.fromJson(responseMap);

        if (responseMap.containsKey('groups')) {
          authorizedUser?.setGroup(responseMap['groups'][0]);
        }
      } else {
        throw Exception('Failed to get user details');
      }
    } catch (e, s) {
      inspect("Getting User Details Error: $e - stack: $s");
      throw Exception("Failed to get user details");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkAuth() async {
    try {
      _isLoading = true;
      // notifyListeners();

      prefs = await SharedPreferences.getInstance();
      String? refreshToken = prefs?.getString('kfone_refresh_token');

      print("Inside Check Auth Initial Refresh Token: ${refreshToken}");

      if (refreshToken != null) {
        await refreshAccessToken(refreshToken);
        await getUserDetails();
        print(
            "Inside Check Auth After Refresh Token: ${tokenResponse?.refreshToken}");

        _isAuthenticated = true;

        notifyListeners();
      }
    } catch (e, s) {
      inspect("Check Auth Error: $e - stack: $s");
      throw Exception("Failed to check Auth");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> validateToken(String token) async {
    final response = await http.post(
      Uri.parse(dotenv.env['TOKEN_INTROSPECT_ENDPOINT']!),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization':
            'Basic eUttTlVfemRYV2kyaTd6RXdEbnN1Q3ljS0pnYTpaSFlQNkNzSW93ckFDYjJkMU8xU2pxSm45TlVh'
      },
      body: {'token': token},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to check access token');
    }

    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse['active']) {
      return true;
    } else {
      return false;
    }
    // _isAuthenticated = jsonResponse['active'] ?? false;
    // notifyListeners();
    // return _isAuthenticated;
  }

  Future<void> saveAccessToken() async {
    prefs = await SharedPreferences.getInstance();
    prefs?.setString('kfone_refresh_token', tokenResponse!.refreshToken!);
  }
}
