import 'package:hive/hive.dart';
import 'package:recipe/core/utils/usecase.dart';
import 'package:recipe/features/recipe/domain/repository/wishlist_repository.dart';

class CloseWishListUsecase extends UseCase<void, Params> {
  final WishListRepository _wishListRepo;

  CloseWishListUsecase(this._wishListRepo);
  
  @override
  Future<void> call(Params param) {
  return _wishListRepo.closeWishListBox();
  }

 
}
