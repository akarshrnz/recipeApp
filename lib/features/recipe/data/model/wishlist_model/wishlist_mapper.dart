import 'package:recipe/features/recipe/data/model/recipe_model/recipe_model.dart';
import 'package:recipe/features/recipe/data/model/wishlist_model/wishlist_model.dart';
import 'package:recipe/features/recipe/domain/entity/recipe_entity.dart';

abstract class WishListMapper<M, E> {
  E toRecipeModel(M e);
  M toWishListModel(E e);
}

class _WishListMapper extends WishListMapper<WishlistModel, RecipeModel> {
  @override
  RecipeModel toRecipeModel(WishlistModel e) {
    return RecipeModel(
        description: e.description, id: e.id, image: e.image, title: e.title);
  }

  @override
  WishlistModel toWishListModel(RecipeModel e) {
    return WishlistModel(
        description: e.description, id: e.id, image: e.image, title: e.title);
  }
}

extension RecipeToWishListConverter on RecipeModel {
  WishlistModel get toWishListModel => _WishListMapper().toWishListModel(this);
}

extension WishListToRecipeConverter on WishlistModel {
  RecipeModel get toRecipeModel => _WishListMapper().toRecipeModel(this);
}

extension RecipieEntityToWishlistConverter on RecipeEntity {
  WishlistModel get toWishListModel => WishlistModel(
      description: description,
      id: id,
      image: image,
      title: title);
}
