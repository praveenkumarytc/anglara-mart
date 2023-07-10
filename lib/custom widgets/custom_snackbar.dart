import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

void showCustomSnackBar(String message, BuildContext context, {bool isError = false}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        key: UniqueKey(),
        content: Text(message),
        margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.down,
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
}
