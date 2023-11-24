import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:recipe/core/config/route/app_route.dart';
import 'package:recipe/core/utils/string_constants.dart';
import 'package:recipe/di_injection.dart';
import 'package:recipe/features/recipe/data/model/recipe_model/recipe_hive.dart';
import 'package:recipe/features/recipe/data/model/wishlist_model/wishlist_model.dart';
import 'package:recipe/features/recipe/presentation/provider/recipe/recipe_provider.dart';
import 'package:recipe/features/recipe/presentation/provider/text_to_speech/text_to_speech_provider.dart';
import 'package:recipe/features/recipe/presentation/provider/wishlist/wishlist_provider.dart';
import 'package:recipe/features/recipe/presentation/screens/home_scren.dart';
import 'package:recipe/features/splash/presentation/splash.dart';
import 'package:recipe/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter<WishlistModel>(WishlistModelAdapter());
  Hive.registerAdapter<RecipeHiveModel>(RecipeHiveModelAdapter());
  await initializeDependency();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => WishListProvider(
                      locator.call(),
                      locator.call(),
                      locator.call(),
                      locator.call(),
                      locator.call(),
                      locator.call(),
                      locator.call()),
                ),
                ChangeNotifierProvider(
                  create: (context) => RecipeProvider(locator.call()),
                ),
                ChangeNotifierProvider(
                  create: (context) => TextToSpeechProvider(locator.call()),
                ),
              ],
              child: 
              // MaterialApp(
              //   home: HomeScreen(),
              //   theme: ThemeData(
              //     primarySwatch: Colors.green,
              //     brightness: Brightness.light,
              //   ),
              //   debugShowCheckedModeBanner: false,
              //   title: 'Recipe App',
              // )

              MaterialApp.router(

              routerConfig: AppRoute().router,
                theme: ThemeData(
                  primarySwatch: Colors.green,
                  brightness: Brightness.light,

                ),
                debugShowCheckedModeBanner: false,
                title: StringConstants.appname,

              ),
              );
        });
  }
}
