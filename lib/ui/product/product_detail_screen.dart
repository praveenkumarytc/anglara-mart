import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/custom%20widgets/custom_appbar.dart';
import 'package:ecommerce/custom%20widgets/custom_button.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/ui/product/components/rating_bar.dart';
import 'package:ecommerce/utils/asset_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/cart_product_model.dart';
import '../../logic/cubit/cart cubit/cart_cubit.dart';
import '../../styles.dart';
import '../../utils/dimensions.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailsScreen({required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: productModel.category ?? ''),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        height: 80,
        child: CustomButton(
            buttonText: 'Add to cart',
            onPressed: () {
              context.read<CartCubit>().addToCart(CartProductModel(
                    quantity: 1,
                    category: productModel.category,
                    description: productModel.description,
                    id: productModel.id,
                    image: productModel.image,
                    price: productModel.price,
                    rating: productModel.rating,
                    title: productModel.title,
                  ));
            }),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade100, spreadRadius: 1, blurRadius: 5)
                ],
              ),
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: productModel.image ?? '',
                placeholder: (context, url) => Image.asset(Images.placeholder),
                errorWidget: (context, url, error) => Image.asset(Images.placeholder),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                productModel.category ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                productModel.title ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RatingBar(rating: productModel.rating!.rate!),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_LARGE),
                    color: 5 > 0 ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.3),
                  ),
                  child: Text(
                    'In Stock',
                    style: poppinsMedium.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '₹ ${productModel.price!.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                productModel.description ?? '',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
