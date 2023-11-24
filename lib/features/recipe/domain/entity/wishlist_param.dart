import 'package:hive/hive.dart';
import 'package:recipe/features/recipe/domain/entity/recipe_entity.dart';

class WishListtParam{
  final Box box;
final RecipeEntity wishList;

  WishListtParam(this.box, this.wishList);

}