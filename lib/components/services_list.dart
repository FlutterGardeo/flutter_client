import 'package:flutter/material.dart';
import 'package:flutter_client/components/device_card.dart';
import 'package:flutter_client/components/service_card.dart';

class ServicesList extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const ServicesList({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        final product = products[index];
        return ServiceCard(
          description: product['description'],
          name: product['name'],
          onAddToCart: () {
            // handle add to cart button press
          },
        );
      },
    );
  }
}
