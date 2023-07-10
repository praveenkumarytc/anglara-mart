import 'package:ecommerce/ui/cart/components/quantity_selector.dart';
import 'package:flutter/material.dart';

import '../../../data/model/cart_product_model.dart';

class CartItemTile extends StatelessWidget {
  final CartProductModel cartProduct;
  final VoidCallback onRemove;
  final ValueChanged<double> onUpdateQuantity;

  const CartItemTile({
    Key? key,
    required this.cartProduct,
    required this.onRemove,
    required this.onUpdateQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(cartProduct.image!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartProduct.title!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Price: ₹${cartProduct.price!.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            children: [
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.clear),
                color: Colors.red,
              ),
              const SizedBox(height: 8),
              QuantitySelector(
                quantity: cartProduct.quantity,
                onQuantityChanged: onUpdateQuantity,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
