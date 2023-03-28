import 'package:flutter/material.dart';
import '../components/devices_list.dart';
import '../components/services_list.dart';

class Dashboard extends StatelessWidget {
  static const routeName = "/dashboard";

  const Dashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          title: const Text('Welcome to Kfone!'),
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
