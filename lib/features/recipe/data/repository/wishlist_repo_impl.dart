import 'package:hive/hive.dart';
import 'package:recipe/core/utils/connection.dart';
import 'package:recipe/core/utils/data_state.dart';
import 'package:recipe/core/utils/failure.dart';
import 'package:recipe/features/recipe/data/data%20source/local/wishlist_local_service.dart';
import 'package:recipe/features/recipe/data/data%20source/remote/wishlist_remote_service.dart';
import 'package:recipe/features/recipe/data/model/recipe_model/recipe_mapper.dart';
import 'package:recipe/features/recipe/data/model/wishlist_model/wishlist_mapper.dart';
import 'package:recipe/features/recipe/data/model/wishlist_model/wishlist_model.dart';
import 'package:recipe/features/recipe/domain/entity/recipe_entity.dart';
import 'package:recipe/features/recipe/domain/repository/wishlist_repository.dart';

class WishListRepoImpl extends WishListRepository {
  final WishListLocalService _wishListService;
  final WishlistRemoteService _wishlistRemoteService;

  WishListRepoImpl(this._wishListService, this._wishlistRemoteService);

  @override
  Future<DataState<bool>> addWishList(
      {required RecipeEntity wishListEntity, required Box box}) async {
    try {
      final hasConncetion = await ConnectionChecker().hasInternetConnection();
      final itemPresent = await checItem(wishListEntity.id!, box);
      if (itemPresent) {
        return const DataFailed("Item exits");
      } else {
        if (hasConncetion) {
          final response =
              await addWishListToRemote(wishListEntity: wishListEntity.toModel);
          if (response is DataSuccess) {
            return await _addToLocal(
                box: box,
                wishListEntity: wishListEntity,
                isRemoteUpdated: true);
          } else {
            return response;
          }
        } else {
          return _addToLocal(box: box, wishListEntity: wishListEntity);
        }
      }
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  Future<bool> checItem(String id, Box box) async {
    return _wishListService.checkItemPresent(id, box);
  }

  // Future<DataState<bool>> addToLocalDb(
  //   RecipeEntity wishListEntity,
  //   Box box,
  //   bool? isRemoteUpdated,
  // ) {
  //   WishlistModel wishListModel = wishListEntity.toWishListModel;
  //   wishListModel.isRemoteUpdated = isRemoteUpdated ?? false;
  //   return _wishListService.addWishList(wishListModel: wishListModel, box: box);
  // }
  @override
  Future<DataState<bool>> addWishListToRemote({
    required RecipeEntity wishListEntity,
  }) {
    return _wishlistRemoteService.addToWishList(wishListEntity.toModel);
  }

  Future<DataState<bool>> _addToLocal(
      {required RecipeEntity wishListEntity,
      required Box box,
      bool? isRemoteUpdated}) {
    WishlistModel wishListModel = wishListEntity.toWishListModel;
    wishListModel.isRemoteUpdated = isRemoteUpdated ?? false;
    return _wishListService.addWishList(wishListModel: wishListModel, box: box);
  }

  @override
  Future<DataState<bool>> clearWishList({required Box box}) {
    return _wishListService.clearWishList(box: box);
  }

  @override
  Future<void> closeWishListBox() {
    return _wishListService.closeWishListBox();
  }

  @override
  Future<DataState<bool>> deleteItemFromWishList(
      {required RecipeEntity wishListEntity, required Box box}) {
    return _wishListService.deleteItemFromWishList(
        box: box, wishListModel: wishListEntity.toWishListModel);
  }

  @override
  Future<DataState<List<RecipeEntity>>> getItemsFromWishList(
      {required Box box}) async {
    final data = await _wishListService.getItemsFromWishList(box: box);
    if (data is DataSuccess && data.data != null) {
      return DataSuccess(
          data.data!.map((model) => model.toRecipeModel).toList());
    } else {
      return DataFailed(data.error ?? "Something went wrong");
    }
  }

  @override
  Future<DataState<Box>> openWishListBox() {
    return _wishListService.openWishListBox();
  }

  @override
  Future<DataState<bool>> backgroundSync(Box box) async {
    try {
      final hasConncetion = await ConnectionChecker().hasInternetConnection();
      if (hasConncetion) {
        final response = await _wishListService.getUnSyncItems(box: box);
        if (response is DataSuccess) {
          final unsyncedList =
              response.data!.map((model) => model.toRecipeModel).toList();
          for (var item in unsyncedList) {
            await _wishlistRemoteService.addToWishList(item);
            await _wishListService.updateStatusForSyncedItem(
                id: item.id!, box: box);
          }
          return const DataSuccess(true);
        } else {
          return const DataFailed("Something went wrong");
        }
      } else {
        throw Failure("No internet");
      }
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<bool>> addWishListToLocal(
      {required RecipeEntity wishListEntity,
      required Box box,
      bool? isRemoteUpdated}) async {
    final itemPresent = await checItem(wishListEntity.id!, box);
    if (itemPresent) {
      return const DataFailed("Item exits");
    } else {
      return _addToLocal(box: box, wishListEntity: wishListEntity);
    }
  }
}
