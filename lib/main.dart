import 'package:ecommerce/logic/cubit/cart%20cubit/cart_cubit.dart';
import 'package:ecommerce/logic/cubit/category%20cubit/category_cubit.dart';
import 'package:ecommerce/logic/cubit/product%20cubit/product_cubit.dart';
import 'package:ecommerce/ui/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/adapters.dart';
import 'firebase_options.dart';
import 'logic/cubit/auth cubit/auth_cubit.dart';
import 'theme/light_theme.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox(hiveBox);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(create: (context) => AuthenticationCubit()),
        BlocProvider<CategoryCubit>(create: (context) => CategoryCubit()),
        BlocProvider<ProductCubit>(create: (context) => ProductCubit()),
        BlocProvider<CartCubit>(create: (context) => CartCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Anglara-Mart',
        navigatorKey: navigatorKey,
        theme: light,
        home: const SplashScreen(),
      ),
    );
  }
}

final navigatorKey = GlobalKey<NavigatorState>();
const hiveBox = "CART_HIVE_BOX";
