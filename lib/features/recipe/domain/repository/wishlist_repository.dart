import 'package:hive/hive.dart';
import 'package:recipe/core/utils/data_state.dart';
import 'package:recipe/features/recipe/domain/entity/recipe_entity.dart';

abstract class WishListRepository {
  Future<DataState<bool>> addWishList(
      {required RecipeEntity wishListEntity, required Box box});
  Future<DataState<bool>> addWishListToLocal(
      {required RecipeEntity wishListEntity,
      required Box box,
      bool? isRemoteUpdated});
  Future<DataState<bool>> addWishListToRemote({
    required RecipeEntity wishListEntity,
  });
   Future<DataState<bool>> backgroundSync(Box box);

  Future<DataState<List<RecipeEntity>>> getItemsFromWishList(
      {required Box box});

  Future<DataState<bool>> deleteItemFromWishList(
      {required RecipeEntity wishListEntity, required Box box});

  Future<DataState<bool>> clearWishList({required Box box});

  Future<DataState<Box>> openWishListBox();

  Future<void> closeWishListBox();
}
