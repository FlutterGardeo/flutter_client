// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_client/views/dashboard.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/user_view_model.dart';

// class AuthChecker extends StatefulHookWidget {
//   static const routeName = '/auth-checker';

//   const AuthChecker({super.key});

//   @override
//   State<AuthChecker> createState() => _AuthCheckerState();
// }

// class _AuthCheckerState extends State<AuthChecker> {
//   String? user;

//   Future<UserViewModel?> getLocalUser() async {
//     // Get user from SharedPreferences.
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? jsonUser = prefs.getString('kfone_user');
//     if (jsonUser == null) {
//       return null;
//     }
//     Map<String, dynamic> userMap = jsonDecode(jsonUser);
//     log(userMap.toString());
//     UserViewModel user = UserViewModel.fromJson(userMap);

//     //context.read(currentUserProvider).state = user;
//     return user;
//   }

//   @override
//   void initState() {
//     super.initState();

//     // Update the user details in the provider for state.
//     getLocalUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //final _currentUserProvider = useProvider(currentUserProvider);
//     //TODO-add auth check here.

//     // If user state is filled with valid id (user found in SharedPreferences, go to dashboard.))
//     if (_currentUserProvider.state.email != null) {
//       return const Dashboard();
//     }
//     return AuthorizationPage();
//   }
// }
