import 'package:recipe/core/utils/data_state.dart';
import 'package:recipe/core/utils/usecase.dart';
import 'package:recipe/features/recipe/domain/entity/recipe_entity.dart';
import 'package:recipe/features/recipe/domain/repository/recipe_repo.dart';

class GetRecipeUsecase
    implements UseCase<DataState<List<RecipeEntity>>, Params> {
  final RecipeRepository _recipeRepository;

  GetRecipeUsecase(this._recipeRepository);
  @override
  Future<DataState<List<RecipeEntity>>> call(Params param) {
    return _recipeRepository.getRecipe();
  }
}
