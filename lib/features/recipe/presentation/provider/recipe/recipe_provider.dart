import 'package:flutter/material.dart';
import 'package:recipe/core/utils/data_state.dart';
import 'package:recipe/core/utils/usecase.dart';
import 'package:recipe/features/recipe/domain/entity/recipe_entity.dart';
import 'package:recipe/features/recipe/domain/usecases/recipe_usecase.dart';

class RecipeProvider with ChangeNotifier {
  bool loading = false;
  String errorMessage = "";
  List<RecipeEntity> recipeList = [];
  final GetRecipeUsecase _getRecipeUsecase;

  RecipeProvider(this._getRecipeUsecase);

//get recipe list
  Future<void> getRecipe() async {
    clearAll();
    loading = true;
    notifyListeners();

    var response = await _getRecipeUsecase(NoParams());
    if (response is DataSuccess) {
      recipeList = response.data ?? [];
    } else {
      errorMessage = response.error ?? "Something went Wrong";
    }
    loading=false;
    notifyListeners();
  }

//clear all fields
  clearAll() {
    loading = false;
    errorMessage = "";
    recipeList = [];
  }
}
