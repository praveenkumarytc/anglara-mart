// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce/helper/route_method.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/ui/dashboard/dash_board.dart';
import 'package:ecommerce/ui/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../components/loading_error.dart';
import 'auth_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthenticationCubit() : super(AuthenticationInitial());
  BuildContext context = navigatorKey.currentContext!;
  Future<void> signInWithGoogle() async {
    try {
      emit(AuthenticationLoading());

      LoadingSheet.show(context);

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        emit(AuthenticationSuccess(user.uid));
        Navigator.pushAndRemoveUntil(
            navigatorKey.currentContext!,
            MaterialPageRoute(
              builder: (context) => const DashBoardScreen(),
            ),
            (route) => false);
      } else {
        emit(AuthenticationFailure('Failed to sign in with Google'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationFailure(e.code));
    }
  }

  Future<void> signOut() async {
    try {
      emit(AuthenticationLoading());
      LoadingSheet.show(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const SplashScreen(),
          ),
          (route) => false);
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();

      emit(AuthenticationInitial());
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }
}
