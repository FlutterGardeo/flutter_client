import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/device_card.dart';
import '../services/auth_service.dart';
import '../services/data_service.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = "/cart";
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late final auth = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.orange[400],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Cart",
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: DataService.getCartDevices(auth.tokenResponse),
        builder: (context, snapshot) {
          double total = 0;

          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            List _items = snapshot.data as List;
            for (var i = 0; i < _items.length; i++) {
              total += _items[i].price as double;
            }

            if (_items.length > 0) {
              return Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
                    children: List.generate(_items.length, (index) {
                      return ListTile(
                          leading: Image.network(
                            _items[index].imageUrl,
                          ),
                          title: Text(
                            _items[index].name,
                          ),
                          subtitle: Text(
                            _items[index].description,
                          ),
                          trailing: Text(
                            _items[index].price.toString(),
                          ),
                          isThreeLine: true,
                          onTap: () => {print("Tapped")});
                      // return DeviceCard(
                      //   imageUrl: _items[index].imageUrl,
                      //   name: _items[index].name,
                      //   description: _items[index].description,
                      //   manufacturer: _items[index].manufacturer,
                      //   price: _items[index].price,
                      //   onAddToCart: () {},
                      // );
                    }),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print("Checkout");
                      // print(total);
                      DataService.checkout(auth.authorizedUser!.id, total, auth.tokenResponse);
                    },
                    child: Text("Checkout"),
                  ),
                ],
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
    );
  }
}
