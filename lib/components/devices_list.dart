import 'package:flutter/material.dart';
import 'package:flutter_client/components/device_card.dart';

class DevicesList extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const DevicesList({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        final product = products[index];
        return DeviceCard(
          imageUrl: product['imageUrl'],
          title: product['title'],
          price: product['price'],
          onAddToCart: () {
            // handle add to cart button press
          },
        );
      },
    );
  }
}
