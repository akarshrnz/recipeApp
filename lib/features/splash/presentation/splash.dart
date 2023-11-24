import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:recipe/core/config/route/route_path.dart';
import 'package:recipe/core/utils/image_contsant.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        context.go(RoutePath.home,
                                  );
      },
    );

    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Image.asset(ImageConstant.logo)],
      ),
    );
  }
}
