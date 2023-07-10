import 'package:ecommerce/custom%20widgets/custom_appbar.dart';
import 'package:ecommerce/custom%20widgets/custom_snackbar.dart';
import 'package:ecommerce/utils/styles.dart';
import 'package:ecommerce/utils/asset_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/cart cubit/cart_cubit.dart';
import '../../logic/cubit/cart cubit/cart_state.dart';
import 'components/cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, this.isBackButton = true});
  final bool? isBackButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Cart', iscart: true, isElevation: true, isBackButtonExist: isBackButton!),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartLoaded) {
            return state.cartItems.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          Images.emptyCart,
                          scale: 2,
                        ),
                      ),
                      Center(
                        child: Text(
                          'Cart is empty',
                          style: poppinsSemiBold.copyWith(color: Colors.grey),
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.cartItems.length,
                          itemBuilder: (context, index) {
                            final cartProduct = state.cartItems[index];
                            return CartItemTile(
                              cartProduct: cartProduct,
                              onRemove: () {
                                context.read<CartCubit>().removeFromCart(cartProduct.id!);
                                showCustomSnackBar('Item removed from cart', context);
                              },
                              onUpdateQuantity: (double quantity) => context.read<CartCubit>().updateQuantity(cartProduct.id!, quantity),
                            );
                          },
                        ),
                      ),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '₹ ${state.totalCartValue.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
          } else if (state is CartError) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else {
            return const Center(
              child: Text('No items in the cart'),
            );
          }
        },
      ),
    );
  }
}
