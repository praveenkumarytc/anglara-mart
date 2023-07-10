import 'package:flutter/material.dart';

import '../utils/color_resources.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 100.0,
        height: 100.0,
        child: Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(ColorResources.PRIMARY_MATERIAL),
              strokeWidth: 3.0,
            ),
          ),
        ),
      ),
    );
  }
}
