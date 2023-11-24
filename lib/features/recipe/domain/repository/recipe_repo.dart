

import 'package:recipe/core/utils/data_state.dart';
import 'package:recipe/features/recipe/data/model/recipe_model/recipe_model.dart';
import 'package:recipe/features/recipe/domain/entity/recipe_entity.dart';

abstract class RecipeRepository{
  Future<DataState<List<RecipeEntity>>> getRecipe();
  
}