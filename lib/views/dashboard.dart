import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client/components/device_card.dart';
import 'package:flutter_client/components/service_card.dart';
import 'package:flutter_client/services/data_service.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
          title: Text('Welcome ' + _currentUserProvider.state.email! + '!'),
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
        body: TabBarView(
          children: [
            FutureBuilder(
              future: DataService.getAllDevices(),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  List _items = snapshot.data as List;

                  if (_items.length > 0) {
                    return ListView(
                      padding: const EdgeInsets.fromLTRB(70, 50, 70, 10),
                      children: List.generate(_items.length, (index) {
                        return DeviceCard(
                          imageUrl: _items[index].imageUrl,
                          name: _items[index].name,
                          description: _items[index].description,
                          manufacturer: _items[index].manufacturer,
                          price: _items[index].price,
                          onAddToCart: () {},
                        );
                      }),
                    );
                  }
                } else if (snapshot.hasError) {
                  if (snapshot.error.runtimeType == DioError) {
                    DioError _error = snapshot.error as DioError;
                    return Text(_error.toString());
                  }
                }
                return const Text("Something went wrong");
              },
            ),
            FutureBuilder(
              future: DataService.getAllServices(),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  List _items = snapshot.data as List;

                  if (_items.length > 0) {
                    return ListView(
                      padding: const EdgeInsets.fromLTRB(70, 50, 70, 10),
                      children: List.generate(_items.length, (index) {
                        return ServiceCard(
                          name: _items[index].name,
                          description: _items[index].description,
                          onAddToCart: () {},
                        );
                      }),
                    );
                  }
                } else if (snapshot.hasError) {
                  if (snapshot.error.runtimeType == DioError) {
                    DioError _error = snapshot.error as DioError;
                    return Text(_error.toString());
                  }
                }
                return const Text("Something went wrong");
              },
            ),
            // DevicesList(products: [
            //   {
            //     'imageUrl': 'https://picsum.photos/250?image=9',
            //     'name': 'Example device 1',
            //     'description': 'Example description 1',
            //     'manufacturer': 'Example manufacturer 1',
            //     'price': 19.99,
            //   },
            //   {
            //     'imageUrl': 'https://picsum.photos/250?image=9',
            //     'name': 'Example device 2',
            //     'description': 'Example description 2',
            //     'manufacturer': 'Example manufacturer 2',
            //     'price': 29.99,
            //   },
            //   {
            //     'imageUrl': 'https://picsum.photos/250?image=9',
            //     'name': 'Example device 3',
            //     'description': 'Example description 3',
            //     'manufacturer': 'Example manufacturer 3',
            //     'price': 39.99,
            //   },
            // ]),
            // ServicesList(products: [
            //   {
            //     'description': 'decsr',
            //     'name': 'Example service 1',
            //   },
            //   {
            //     'description': 'decsr',
            //     'name': 'Example service 2',
            //   },
            //   {
            //     'description': 'decsr',
            //     'name': 'Example service 3',
            //   },
            // ]),
          ],
        ),
      ),
    );
  }
}
