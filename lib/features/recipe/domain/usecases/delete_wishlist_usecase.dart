import 'package:hive/hive.dart';
import 'package:recipe/core/utils/data_state.dart';
import 'package:recipe/core/utils/usecase.dart';
import 'package:recipe/features/recipe/domain/entity/wishlist_param.dart';
import 'package:recipe/features/recipe/domain/repository/wishlist_repository.dart';

class DeleteWishListUsecase extends UseCase<DataState<bool>, WishListtParam> {
  final WishListRepository _wishListRepo;

  DeleteWishListUsecase(this._wishListRepo);

  @override
  Future<DataState<bool>> call(WishListtParam param) {
    return _wishListRepo.deleteItemFromWishList(box: param.box,wishListEntity: param.wishList);
  }
}
