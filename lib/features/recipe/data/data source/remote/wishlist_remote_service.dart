import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe/core/utils/data_state.dart';
import 'package:recipe/core/utils/endpoints.dart';
import 'package:recipe/core/utils/failure.dart';
import 'package:recipe/features/recipe/data/model/recipe_model/recipe_model.dart';



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
          .collection(Endpoints.userCollection)
          .doc(Endpoints.userId)
          .collection(Endpoints.recipeCollection)
          .add(recipeModel.toJson());
      return const DataSuccess(true);
    } catch (e) {
      throw DataFailed(e.toString());
    }
  }
}
