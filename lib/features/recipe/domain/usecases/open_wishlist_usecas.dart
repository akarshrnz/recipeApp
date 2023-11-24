import 'package:hive/hive.dart';
import 'package:recipe/core/utils/data_state.dart';
import 'package:recipe/core/utils/usecase.dart';
import 'package:recipe/features/recipe/domain/repository/wishlist_repository.dart';

class OpenWishListUsecase extends UseCase<DataState<Box>, Params> {
  final WishListRepository _wishListRepo;

  OpenWishListUsecase(this._wishListRepo);

  @override
  Future<DataState<Box>> call(Params param) {
    return _wishListRepo.openWishListBox();
  }
}
