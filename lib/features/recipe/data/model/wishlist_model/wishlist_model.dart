import 'package:hive/hive.dart';
part 'wishlist_model.g.dart';

@HiveType(typeId: 1)
class WishlistModel extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;

  @HiveField(3)
  String? image;
  @HiveField(4)
  bool? isRemoteUpdated;

  WishlistModel({
    this.title,
    this.isRemoteUpdated,
    this.description,
    this.id,
    this.image,
  });
}
