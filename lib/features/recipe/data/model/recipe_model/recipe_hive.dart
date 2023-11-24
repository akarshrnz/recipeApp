import 'package:hive/hive.dart';
part 'recipe_hive.g.dart';

@HiveType(typeId: 2)
class RecipeHiveModel extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;

  @HiveField(3)
  String? image;

  RecipeHiveModel({
    this.title,
    this.description,
    this.id,
    this.image,
  });
}
