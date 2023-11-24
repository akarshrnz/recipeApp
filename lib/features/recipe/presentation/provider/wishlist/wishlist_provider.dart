import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipe/core/utils/app_constant_widgets.dart';
import 'package:recipe/core/utils/color_constant.dart';
import 'package:recipe/core/utils/data_state.dart';
import 'package:recipe/core/utils/failure.dart';
import 'package:recipe/core/utils/usecase.dart';
import 'package:recipe/features/recipe/domain/entity/recipe_entity.dart';
import 'package:recipe/features/recipe/domain/entity/wishlist_param.dart';
import 'package:recipe/features/recipe/domain/usecases/add_wishlist_local_usecase.dart';
import 'package:recipe/features/recipe/domain/usecases/add_wishlist_usecase.dart';
import 'package:recipe/features/recipe/domain/usecases/clear_wishlist_usecase.dart';
import 'package:recipe/features/recipe/domain/usecases/close_wishlist_usecase.dart';
import 'package:recipe/features/recipe/domain/usecases/delete_wishlist_usecase.dart';
import 'package:recipe/features/recipe/domain/usecases/get_wishlist_usecase.dart';
import 'package:recipe/features/recipe/domain/usecases/open_wishlist_usecas.dart';

class WishListProvider with ChangeNotifier {
  final OpenWishListUsecase _openWishListUsecase;
  final AddWishListUsecase _addWishListUsecase;
  final GetWishListUsecase _getWishListUsecase;
  final DeleteWishListUsecase _deleteWishListUsecase;
  final SyncDataUsecase _syncWishListUsecase;
  final CloseWishListUsecase _closeWishListUsecase;
  final AddWishListLocalUsecase _addWishListLocalUsecase;

  List<RecipeEntity> wishList = [];
  bool isSyncing = false;

  WishListProvider(
      this._openWishListUsecase,
      this._addWishListUsecase,
      this._getWishListUsecase,
      this._deleteWishListUsecase,
      this._syncWishListUsecase,
      this._closeWishListUsecase,
      this._addWishListLocalUsecase);

  Future<void> syncData() async {
    isSyncing = true;
    notifyListeners();
    try {
      Box box = await _openBox();
      await _syncWishListUsecase(box);
      await _closeBox();
    } catch (e) {}
    isSyncing = false;
    notifyListeners();
  }

//add to local db
  Future<void> addWishList(RecipeEntity recipe) async {
    try {
      Box box = await _openBox();
      var response = isSyncing
          ? await _addWishListLocalUsecase(WishListtParam(box, recipe))
          : await _addWishListUsecase(WishListtParam(box, recipe));

      if (response is DataSuccess) {
        var newList = await _getUserWishListdata(box);
        if (newList.isNotEmpty) {
          _showMessage(
              message: "Successfully added to wishlist", isError: false);
        }
        wishList = newList.isEmpty ? [] : newList;
      } else {
        _showMessage(message: response.error, isError: true);
      }
    } catch (e) {
      _showMessage(isError: true);
    }
    await _closeBox();
    notifyListeners();
  }

  //get all wishlst from loal db
  Future<void> getWishList() async {
    try {
      Box box = await _openBox();
      var newList = await _getUserWishListdata(box);
      await _closeBox();
      wishList = newList;
    } catch (e) {
      wishList = [];
    }
    notifyListeners();
  }

  //delete wishlist
  Future<void> deleteWishList(RecipeEntity recipe) async {
    try {
      Box box = await _openBox();
      var response = await _deleteWishListUsecase(WishListtParam(box, recipe));

      if (response is DataSuccess) {
        var newList = await _getUserWishListdata(box);
        _showMessage(
            message: "Successfully removed from wishlist", isError: false);

        wishList = newList;
      } else {
        _showMessage(message: response.error, isError: true);
      }
    } catch (e) {
      _showMessage(isError: true);
    }
    await _closeBox();
  }

  Future<List<RecipeEntity>> _getUserWishListdata(Box box) async {
    var response = await _getWishListUsecase(box);
    if (response is DataSuccess) {
      return response.data ?? [];
    } else {
      return [];
    }
  }

  Future<Box> _openBox() async {
    var response = await _openWishListUsecase(NoParams());
    if (response is DataSuccess) {
      return response.data!;
    } else {
      throw Failure(response.error ?? "Something went wrong");
    }
  }

  Future<void> _closeBox() async {
    await _closeWishListUsecase(NoParams());
  }

  _showMessage({String? message, required isError}) {
    AppConstWidget.toastMsg(
        msg: message ?? "Something went wrong",
        backgroundColor: isError ? ColorConstant.red : ColorConstant.green);
  }
}
