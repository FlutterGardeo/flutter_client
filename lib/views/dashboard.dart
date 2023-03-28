import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/asgardeo_service.dart';
import '../components/devices_list.dart';
import '../components/services_list.dart';
import '../providers/user_provider.dart';

class Dashboard extends HookWidget {
  static const routeName = '/dashboard';

  const Dashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _currentUserProvider = useProvider(currentUserProvider);
    print(_currentUserProvider.state.userName);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.devices),
                text: "Devices",
              ),
              Tab(
                icon: Icon(Icons.design_services),
                text: "Services",
              ),
            ],
          ),
          title: Text('Welcome to Kfone!' + _currentUserProvider.state.email!),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                // handle logout here
                // TODO

                // SharedPreferences prefs = await SharedPreferences.getInstance();
                // AuthorizationTokenResponse tokenResponse = prefs.get("user") as AuthorizationTokenResponse;

                // var result = await AuthController.logoutAction(tokenResponse);
                // // print(result);
                // print(result);

                // await SharedPreferences.getInstance();
                // prefs.setString("user", "");
              },
              tooltip: 'Logout',
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            DevicesList(products: [
              {
                'imageUrl': 'https://picsum.photos/250?image=9',
                'name': 'Example device 1',
                'description': 'Example description 1',
                'manufacturer': 'Example manufacturer 1',
                'price': 19.99,
              },
              {
                'imageUrl': 'https://picsum.photos/250?image=9',
                'name': 'Example device 2',
                'description': 'Example description 2',
                'manufacturer': 'Example manufacturer 2',
                'price': 29.99,
              },
              {
                'imageUrl': 'https://picsum.photos/250?image=9',
                'name': 'Example device 3',
                'description': 'Example description 3',
                'manufacturer': 'Example manufacturer 3',
                'price': 39.99,
              },
            ]),
            ServicesList(products: [
              {
                'description': 'decsr',
                'name': 'Example service 1',
              },
              {
                'description': 'decsr',
                'name': 'Example service 2',
              },
              {
                'description': 'decsr',
                'name': 'Example service 3',
              },
            ]),
          ],
        ),
      ),
    );
  }
}
