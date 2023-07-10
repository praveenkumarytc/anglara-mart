import 'package:ecommerce/utils/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedButtonStyle extends StatelessWidget {
  final String title;
  const RoundedButtonStyle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorResources.PRIMARY_MATERIAL,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: ColorResources.WHITE,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
      ),
    );
  }
}
