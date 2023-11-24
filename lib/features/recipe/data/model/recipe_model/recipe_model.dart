import 'package:recipe/features/recipe/data/model/recipe_model/recipe_hive.dart';
import 'package:recipe/features/recipe/domain/entity/recipe_entity.dart';

class RecipeModel extends RecipeEntity {
  RecipeModel({
    String? id,
    String? title,
    String? image,
    String? description,
  }) : super(description: description, id: id, image: image, title: title);

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'description': description,
    };
  }

  RecipeHiveModel toHive() {
    return RecipeHiveModel(
      description: description,
      id: id,
      image: image,
      title: title,
    );
  }
   RecipeModel fromHive(RecipeHiveModel recipe) {
    return RecipeModel(
      description:recipe. description,
      id:recipe. id,
      image: recipe.image,
      title:recipe. title,
    );
  }
}
