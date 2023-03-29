import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final String? id;
  final String? name;
  final double price;
  final String? description;
  final String? manufacturer;
  final String? imageUrl;
  final VoidCallback onAddToCart;

  const DeviceCard({
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.manufacturer,
    required this.imageUrl,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            imageUrl!,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name!,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description!,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              manufacturer!,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '\$${price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: onAddToCart,
            child: Text('Add to cart'),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
