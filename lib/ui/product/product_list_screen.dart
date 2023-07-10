import 'package:ecommerce/custom%20widgets/custom_appbar.dart';
import 'package:ecommerce/custom%20widgets/progress_indicator.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/logic/cubit/cart%20cubit/cart_cubit.dart';
import 'package:ecommerce/logic/cubit/cart%20cubit/cart_state.dart';
import 'package:ecommerce/logic/cubit/product%20cubit/product_cubit.dart';
import 'package:ecommerce/logic/cubit/product%20cubit/product_state.dart';
import 'package:ecommerce/ui/product/components/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/styles.dart';
import '../../utils/dimensions.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.categoryName});
  final String categoryName;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  fetchProducts() {
    context.read<ProductCubit>().fetchProduct(widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: CustomAppBar(
        title: widget.categoryName,
        isBackButtonExist: true,
        isCenter: false,
        isElevation: true,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
        if (state is ProductLoadedState) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        width: 1170,
                        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3,
                            crossAxisCount: 1,
                            mainAxisSpacing: 13,
                            crossAxisSpacing: 13,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.products!.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            ProductModel product = state.products![index];
                            return ProductWidget(
                              productModel: product,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              cartTile(context),
            ],
          );
        } else {
          return const ProgressBar();
        }
      }),
    );
  }
}

Widget cartTile(BuildContext context) {
  return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
    if (state is CartLoaded) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(.89), borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Total Item',
                    style: poppinsMedium.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      color: Theme.of(context).cardColor,
                    )),
                Text('${state.cartItems.length} items', style: poppinsMedium.copyWith(color: Theme.of(context).cardColor)),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Total Amount',
                    style: poppinsMedium.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      color: Theme.of(context).cardColor,
                    )),
                Text(
                  '₹ ${state.totalCartValue.toStringAsFixed(2)}',
                  style: poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).cardColor),
                ),
              ]),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  });
}
