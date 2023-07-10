import 'package:ecommerce/ui/auth%20screens/authentication.dart';
import 'package:ecommerce/ui/dashboard/dash_board.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return GoogleSignInPage();
    } else {
      return const DashBoardScreen();
    }
  }
}
