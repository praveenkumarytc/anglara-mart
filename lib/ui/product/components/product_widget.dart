import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/data/model/cart_product_model.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/helper/route_method.dart';
import 'package:ecommerce/logic/cubit/cart%20cubit/cart_cubit.dart';
import 'package:ecommerce/ui/product/components/rating_bar.dart';
import 'package:ecommerce/ui/product/product_detail_screen.dart';
import 'package:ecommerce/utils/asset_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../custom widgets/custom_snackbar.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel productModel;

  const ProductWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: InkWell(
        onTap: () {
          routeTo(
              context,
              ProductDetailsScreen(
                productModel: productModel,
              ));
        },
        child: Container(
          height: 85,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Row(
            children: [
              productModel.image != null
                  ? Container(
                      height: 85,
                      width: 85,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: productModel.image!,
                          placeholder: (context, url) => Image.asset(Images.placeholder),
                          errorWidget: (context, url, error) => Image.asset(Images.placeholder),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        productModel.title ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      productModel.rating!.rate != null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: RatingBar(rating: productModel.rating!.rate!, size: 10),
                            )
                          : const SizedBox(),
                      Text(
                        '₹ ${productModel.price?.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                      child: SizedBox(
                    height: 15,
                  )),
                  InkWell(
                    onTap: () {
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
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.all(2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.add, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
