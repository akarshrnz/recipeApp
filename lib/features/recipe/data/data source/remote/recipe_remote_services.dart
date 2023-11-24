import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe/core/utils/data_state.dart';
import 'package:recipe/core/utils/endpoints.dart';
import 'package:recipe/core/utils/failure.dart';
import 'package:recipe/features/recipe/data/model/recipe_model/recipe_model.dart';

abstract class RecipeService {
  Future<DataState<List<RecipeModel>>> getRecipe();
}

class RecipeServiceImpl implements RecipeService {
  final FirebaseFirestore _firestore;

  RecipeServiceImpl(this._firestore);

  @override
  Future<DataState<List<RecipeModel>>> getRecipe() async {
    try {
      
      QuerySnapshot querySnapshot = await _firestore.collection(Endpoints.recipeCollection).get();
           
      return DataSuccess(querySnapshot.docs
          .map(
              (doc) => RecipeModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      
      throw DataFailed(e.toString());
    }
  }
}
