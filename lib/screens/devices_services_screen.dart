import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client/components/device_card.dart';
import 'package:flutter_client/components/service_card.dart';
import 'package:flutter_client/services/data_service.dart';
import 'package:google_fonts/google_fonts.dart';

class DevicesAndServices extends StatelessWidget {
  static const routeName = "/devices-and-services";

  const DevicesAndServices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.orange[400],
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
          title: Text(
            "Devices & Services",
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: Icon(
            Icons.ac_unit,
            color: Colors.white,
          ), // Add an icon or logo here
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                // handle logout here
                // TODO
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
