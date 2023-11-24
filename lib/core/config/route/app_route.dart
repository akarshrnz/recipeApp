import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/core/config/route/route_path.dart';
import 'package:recipe/features/recipe/domain/entity/recipe_entity.dart';
import 'package:recipe/features/recipe/presentation/screens/home_scren.dart';
import 'package:recipe/features/recipe/presentation/screens/recipe_details_screen.dart';
import 'package:recipe/features/splash/presentation/splash.dart';

class AppRoute {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: RoutePath.home,
        pageBuilder: (context, state) {
          return const MaterialPage(
              child: HomeScreen());
        },
      ),
      
      GoRoute(
        path: RoutePath.recipeDetail,
        pageBuilder: (context, state) {
          return MaterialPage(
              child: RecipeDetail(recipe: state.extra as RecipeEntity));
        },
      ),GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: SplashScreen());
        },
      ),
      
    ],
  );
}
