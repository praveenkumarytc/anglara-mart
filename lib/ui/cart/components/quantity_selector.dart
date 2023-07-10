import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final double quantity;
  final ValueChanged<double> onQuantityChanged;

  const QuantitySelector({super.key, required this.quantity, required this.onQuantityChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => onQuantityChanged(quantity - 1),
          icon: const Icon(Icons.remove),
        ),
        Text(quantity.toString()),
        IconButton(
          onPressed: () => onQuantityChanged(quantity + 1),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
