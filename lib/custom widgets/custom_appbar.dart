import 'dart:isolate';

import 'package:ecommerce/helper/route_method.dart';
import 'package:ecommerce/logic/cubit/cart%20cubit/cart_cubit.dart';
import 'package:ecommerce/logic/cubit/cart%20cubit/cart_state.dart';
import 'package:ecommerce/utils/asset_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../styles.dart';
import '../ui/cart/cart_screen.dart';
import '../utils/dimensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonExist;
  final Function? onBackPressed;
  final bool isCenter;
  final bool isElevation;
  final bool iscart;
  const CustomAppBar({
    super.key,
    required this.title,
    this.isBackButtonExist = true,
    this.onBackPressed,
    this.isCenter = true,
    this.isElevation = false,
    this.iscart = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).textTheme.bodyMedium!.color)),
      centerTitle: isCenter ? true : false,
      leading: isBackButtonExist
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).textTheme.bodyLarge!.color),
              onPressed: () => onBackPressed != null ? onBackPressed!() : Navigator.pop(context),
            )
          : const SizedBox(),
      backgroundColor: Theme.of(context).cardColor,
      elevation: isElevation ? 2 : 0,
      actions: [
        iscart
            ? SizedBox.shrink()
            : BlocBuilder<CartCubit, CartState>(builder: (context, state) {
                if (state is CartLoaded) {
                  return Container(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: IconButton(
                      icon: Stack(clipBehavior: Clip.none, children: [
                        Image.asset(Images.cartImage, width: 23, height: 25, color: Theme.of(context).textTheme.bodyLarge!.color),
                        Positioned(
                          top: -7,
                          right: -2,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                            child: Text(state.cartItems.length.toString(), style: TextStyle(color: Theme.of(context).cardColor, fontSize: 10)),
                          ),
                        ),
                      ]),
                      onPressed: () {
                        routeTo(context, CartScreen());
                      },
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
                ;
              })
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}
