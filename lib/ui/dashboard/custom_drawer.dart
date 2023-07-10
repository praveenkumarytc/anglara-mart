// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce/helper/route_method.dart';
import 'package:ecommerce/ui/cart/cart_screen.dart';
import 'package:ecommerce/ui/profile/profile_page.dart';
import 'package:ecommerce/utils/color_resources.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../logic/cubit/auth cubit/auth_cubit.dart';
import '../../utils/asset_images.dart';
import '../splash_screen.dart';

class CustomDrawer extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            decoration: BoxDecoration(
              color: ColorResources.PRIMARY_MATERIAL.withOpacity(.6),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(user!.photoURL!),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    user.displayName!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              popPage(context);
              routeTo(
                  context,
                  ProfilePage(
                    backExist: true,
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text(
              'Cart',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              popPage(context);
              routeTo(context, const CartScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () async {
              await context.read<AuthenticationCubit>().signOut();
            },
          ),
        ],
      ),
    );
  }
}
