// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

import '../utils/styles.dart';
import '../utils/color_resources.dart';
import '../utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;
  final double margin;
  final Color? textColor;
  final Color? backgroundColor;
  final double borderRadius;
  CustomButton({required this.buttonText, required this.onPressed, this.margin = 0, this.textColor, this.borderRadius = 10, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(margin),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor ?? (onPressed == null ? ColorResources.PRIMARY_BUTTON_COLOR : Theme.of(context).primaryColor),
          minimumSize: Size(MediaQuery.of(context).size.width / 3, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        ),
        child: Text(buttonText,
            style: poppinsMedium.copyWith(
              color: textColor ?? Theme.of(context).cardColor,
              fontSize: Dimensions.FONT_SIZE_LARGE,
            )),
      ),
    );
  }
}
