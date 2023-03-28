import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String description;
  final String name;
  final VoidCallback onAddToCart;

  const ServiceCard({
    Key? key,
    required this.description,
    required this.name,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description, style: Theme.of(context).textTheme.bodyMedium),
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
