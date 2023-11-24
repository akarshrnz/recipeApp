import 'package:hive/hive.dart';
import 'package:recipe/core/utils/data_state.dart';
import 'package:recipe/core/utils/failure.dart';
import 'package:recipe/core/utils/hive_box_const.dart';
import 'package:recipe/features/recipe/data/model/wishlist_model/wishlist_model.dart';

abstract class WishListLocalService {
  Future<DataState<bool>> addWishList(
      {required WishlistModel wishListModel, required Box box});
  Future<DataState<List<WishlistModel>>> getItemsFromWishList(
      {required Box box});
  Future<DataState<bool>> deleteItemFromWishList(
      {required WishlistModel wishListModel, required Box box});
  Future<DataState<bool>> clearWishList({required Box box});
  Future<DataState<Box>> openWishListBox();
  Future<void> closeWishListBox();
  Future<bool> checkItemPresent(String id,Box box);
  Future<void> updateStatusForSyncedItem(
      {required String id, required Box box});

  Future<DataState<List<WishlistModel>>> getUnSyncItems({required Box box});
}

class WishListServiceImpl extends WishListLocalService {
  @override
  Future<DataState<Box>> openWishListBox() async {
    try {
      print("open box");
      Box box = await Hive.openBox(HiveBoxConstants.wishListBoxName);
      return DataSuccess(box);
    } catch (e) {
      print("error >>>>>>>>");
      print(e.toString());
      return const DataFailed("Something went wrong");
    }
  }

  @override
  Future<void> closeWishListBox() async {
    try {
      await Hive.box(HiveBoxConstants.wishListBoxName).close();
    } catch (e) {
      throw Failure("Something went wrong");
    }
  }

  @override
  Future<DataState<bool>> addWishList(
      {required WishlistModel wishListModel, required Box box}) async {
    try {
      await box.put(wishListModel.id, wishListModel);

      return const DataSuccess(true);
    } catch (e) {
      return const DataFailed("Something went wrong");
    }
  }

  @override
  Future<DataState<bool>> clearWishList({required Box box}) async {
    try {
      box.clear();

      return const DataSuccess(true);
    } catch (e) {
      return const DataFailed("Something went wrong");
    }
  }

  @override
  Future<DataState<bool>> deleteItemFromWishList(
      {required WishlistModel wishListModel, required Box box}) async {
    try {
      box.delete(
        wishListModel.id,
      );

      return const DataSuccess(true);
    } catch (e) {
      return const DataFailed("Something went wrong");
    }
  }

  @override
  Future<DataState<List<WishlistModel>>> getItemsFromWishList(
      {required Box box}) async {
    try {
      List<WishlistModel> res = box.values.toList().cast<WishlistModel>();

      return DataSuccess(res);
    } catch (e) {
      return const DataFailed("Something went wrong");
    }
  }

  @override
  Future<DataState<List<WishlistModel>>> getUnSyncItems(
      {required Box box}) async {
    try {
      List<WishlistModel> res = box.values.toList().cast<WishlistModel>();

      return DataSuccess(
          res.where((item) => item.isRemoteUpdated == false).toList());
    } catch (e) {
      return const DataFailed("Something went wrong");
    }
  }
 @override
  Future<void> updateStatusForSyncedItem(
      {required String id, required Box box}) async {
    WishlistModel? existingModel = box.get(id);

      if (existingModel != null) {
        existingModel.isRemoteUpdated = true;

        await box.put(id, existingModel);
      }
  }
  
  @override
  Future<bool> checkItemPresent(String id,Box box)async {
    return box.containsKey(id);
  }
}
