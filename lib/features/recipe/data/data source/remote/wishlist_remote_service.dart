import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe/core/utils/data_state.dart';
import 'package:recipe/core/utils/failure.dart';
import 'package:recipe/features/recipe/data/model/recipe_model/recipe_model.dart';

String userId = "testUser!23";

abstract class WishlistRemoteService {
  Future<DataState<bool>> addToWishList(RecipeModel recipeModel);
}

class WishlistRemoteServiceImpl implements WishlistRemoteService {
  final FirebaseFirestore _firestore;

  WishlistRemoteServiceImpl(this._firestore);

  @override
  Future<DataState<bool>> addToWishList(RecipeModel recipeModel) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('recipes')
          .add(recipeModel.toJson());
      return const DataSuccess(true);
    } catch (e) {
      throw DataFailed(e.toString());
    }
  }
}
