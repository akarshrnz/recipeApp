import 'package:hive/hive.dart';
import 'package:recipe/core/utils/data_state.dart';
import 'package:recipe/core/utils/hive_box_const.dart';
import 'package:recipe/features/recipe/data/model/recipe_model/recipe_hive.dart';
import 'package:recipe/features/recipe/data/model/recipe_model/recipe_model.dart';

abstract class RecipeLocalService {
  Future<DataState<bool>> addRecipesLocal({
    required List<RecipeHiveModel> recipes,
  });
  Future<DataState<List<RecipeModel>>> getRecipeslocal();

  Future<DataState<bool>> clearRecipesLocal();
}

class RecipeLocalServiceImpl extends RecipeLocalService {
  @override
  Future<DataState<bool>> addRecipesLocal(
      {required List<RecipeHiveModel> recipes}) async {
    try {
  
      Box box = await Hive.openBox(HiveBoxConstants.recipeBoxName);
      box.clear();
      for (var item in recipes) {
       
        await box.put(item.id, item);
      }
      

      await Hive.box(HiveBoxConstants.recipeBoxName).close();
      return const DataSuccess(true);
    } catch (e) {
      return const DataFailed("Something went wrong");
    }
  }

  @override
  Future<DataState<bool>> clearRecipesLocal() async {
    try {
      Box box = await Hive.openBox(HiveBoxConstants.recipeBoxName);
      box.clear();
      await Hive.box(HiveBoxConstants.recipeBoxName).close();

      return const DataSuccess(true);
    } catch (e) {
      return const DataFailed("Something went wrong");
    }
  }

  @override
  Future<DataState<List<RecipeModel>>> getRecipeslocal() async {
    try {
      Box box = await Hive.openBox(HiveBoxConstants.recipeBoxName);
      List<RecipeHiveModel> res = box.values.toList().cast<RecipeHiveModel>();

    
      await Hive.box(HiveBoxConstants.recipeBoxName).close();

      return DataSuccess(res.map((e) => RecipeModel().fromHive(e)).toList());
    } catch (e) {
      return const DataFailed("Something went wrong");
    }
  }
}
