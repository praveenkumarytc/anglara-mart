import 'package:flutter/cupertino.dart';

routeTo(BuildContext context, route) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => route));
}

popPage(BuildContext context) {
  Navigator.pop(context);
}
