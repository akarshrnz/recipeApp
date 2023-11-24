import 'package:hive/hive.dart';
import 'package:recipe/core/utils/data_state.dart';
import 'package:recipe/core/utils/usecase.dart';
import 'package:recipe/features/recipe/domain/repository/wishlist_repository.dart';

class SyncDataUsecase extends UseCase<DataState<bool>, Box> {
  final WishListRepository _wishListRepo;

  SyncDataUsecase(this._wishListRepo);

  @override
  Future<DataState<bool>> call(Box param) {
    return _wishListRepo.clearWishList(box: param);
  }
}
