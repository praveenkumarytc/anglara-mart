import 'package:ecommerce/components/slide_fade_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final _kTextStyle = TextStyle(fontWeight: FontWeight.w500, color: const Color(0xFF9A9A9A), fontSize: 14);

class AuthSwitchButton extends StatelessWidget {
  final bool showSignIn;
  final VoidCallback onTap;
  const AuthSwitchButton({super.key, required this.onTap, required this.showSignIn});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 30,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: SlideFadeSwitcher(
            child: showSignIn
                ? Text(
                    "Don't have an account? Sign Up",
                    key: const ValueKey("SignIn"),
                    style: _kTextStyle,
                  )
                : Text(
                    "Already have an account? Sign In",
                    key: const ValueKey("SignUp"),
                    style: _kTextStyle,
                  ),
          ),
        ),
      ),
    );
  }
}
