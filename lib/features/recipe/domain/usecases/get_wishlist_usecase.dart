import 'package:hive/hive.dart';
import 'package:recipe/core/utils/data_state.dart';
import 'package:recipe/core/utils/usecase.dart';
import 'package:recipe/features/recipe/domain/entity/recipe_entity.dart';
import 'package:recipe/features/recipe/domain/repository/wishlist_repository.dart';

class GetWishListUsecase extends UseCase<DataState<List<RecipeEntity>>, Box> {
  final WishListRepository _wishListRepo;

  GetWishListUsecase(this._wishListRepo);

  @override
  Future<DataState<List<RecipeEntity>>> call(Box param) {
    return _wishListRepo.getItemsFromWishList(box: param);
  }
}
