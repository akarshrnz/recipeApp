
import 'package:recipe/core/utils/mapper.dart';

import 'package:recipe/features/recipe/data/model/recipe_model/recipe_model.dart';
import 'package:recipe/features/recipe/domain/entity/recipe_entity.dart';



class _RecipieEntityToModel extends Mapper<RecipeModel, RecipeEntity> {
  @override
  RecipeEntity toEntity(RecipeModel e) {
    // TODO: implement toEntity
    throw UnimplementedError();
  }

  @override
  RecipeModel toModel(RecipeEntity e) {
  return RecipeModel(description: e.description,id: e.id,image: e.image,title: e.title,);
  }
 

}
extension RecieEntityToModel on RecipeEntity {
  RecipeModel get toModel => _RecipieEntityToModel().toModel(this);
}
