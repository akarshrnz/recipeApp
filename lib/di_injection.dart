import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe/features/recipe/data/data%20source/local/recipe_local_service.dart';
import 'package:recipe/features/recipe/data/data%20source/local/wishlist_local_service.dart';

import 'package:recipe/features/recipe/data/data%20source/remote/recipe_services.dart';
import 'package:recipe/features/recipe/data/data%20source/remote/wishlist_remote_service.dart';
import 'package:recipe/features/recipe/data/repository/recipe_repo_impl.dart';
import 'package:recipe/features/recipe/data/repository/wishlist_repo_impl.dart';
import 'package:recipe/features/recipe/domain/repository/recipe_repo.dart';
import 'package:recipe/features/recipe/domain/repository/wishlist_repository.dart';
import 'package:recipe/features/recipe/domain/usecases/add_wishlist_local_usecase.dart';
import 'package:recipe/features/recipe/domain/usecases/add_wishlist_usecase.dart';
import 'package:recipe/features/recipe/domain/usecases/clear_wishlist_usecase.dart';
import 'package:recipe/features/recipe/domain/usecases/close_wishlist_usecase.dart';
import 'package:recipe/features/recipe/domain/usecases/delete_wishlist_usecase.dart';
import 'package:recipe/features/recipe/domain/usecases/get_wishlist_usecase.dart';
import 'package:recipe/features/recipe/domain/usecases/open_wishlist_usecas.dart';
import 'package:recipe/features/recipe/domain/usecases/recipe_usecase.dart';

GetIt locator = GetIt.instance;
Future<void> initializeDependency() async {
  //firebase
  locator.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  locator.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
//text to speech
 locator.registerLazySingleton<FlutterTts>(
      () => FlutterTts());
  //recipe
  locator.registerLazySingleton<RecipeService>(
      () => RecipeServiceImpl(locator.call()));
      locator.registerLazySingleton<RecipeLocalService>(
      () => RecipeLocalServiceImpl());

  locator.registerLazySingleton<RecipeRepository>(
      () => RecipeRepositoryImpl(locator.call(),locator.call()));
  locator.registerLazySingleton<GetRecipeUsecase>(
      () => GetRecipeUsecase(locator.call()));

  //locator.registerFactory(() => RecipeProvider(locator.call()));

  //wishlist
  locator.registerSingleton<WishListLocalService>(WishListServiceImpl());
    locator.registerSingleton<WishlistRemoteService>(WishlistRemoteServiceImpl(locator.call()));
  locator
      .registerSingleton<WishListRepository>(WishListRepoImpl(locator.call(),locator.call()));
  locator.registerSingleton<AddWishListUsecase>(
      AddWishListUsecase(locator.call()));
  locator.registerSingleton<GetWishListUsecase>(
      GetWishListUsecase(locator.call()));

       locator.registerSingleton<AddWishListLocalUsecase>(
      AddWishListLocalUsecase(locator.call()));
  locator.registerSingleton<DeleteWishListUsecase>(
      DeleteWishListUsecase(locator.call()));
  locator.registerSingleton<SyncDataUsecase>(
      SyncDataUsecase(locator.call()));
  locator.registerSingleton<CloseWishListUsecase>(
      CloseWishListUsecase(locator.call()));
  locator.registerSingleton<OpenWishListUsecase>(
      OpenWishListUsecase(locator.call()));
}
