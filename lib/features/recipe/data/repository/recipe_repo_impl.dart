import 'package:recipe/core/utils/connection.dart';
import 'package:recipe/core/utils/data_state.dart';
import 'package:recipe/features/recipe/data/data%20source/local/recipe_local_service.dart';
import 'package:recipe/features/recipe/data/data%20source/remote/recipe_services.dart';
import 'package:recipe/features/recipe/data/model/recipe_model/recipe_model.dart';
import 'package:recipe/features/recipe/domain/entity/recipe_entity.dart';
import 'package:recipe/features/recipe/domain/repository/recipe_repo.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeService _recipeService;
  final RecipeLocalService _recipeLocalService;

  RecipeRepositoryImpl(this._recipeService, this._recipeLocalService);

  @override
  Future<DataState<List<RecipeEntity>>> getRecipe() async {
    try {
      final hasConncetion = await ConnectionChecker().hasInternetConnection();
      if (hasConncetion) {
        final response = await _recipeService.getRecipe();
        if (response is DataSuccess &&
            response.data != null &&
            response.data!.isNotEmpty) {
          
         await _recipeLocalService.addRecipesLocal(
              recipes:
                  response.data!.map((e) => e.toHive()).toList());
        }
        return response;
      } else {
        final response = await _recipeLocalService.getRecipeslocal();
        return response;
      }
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
