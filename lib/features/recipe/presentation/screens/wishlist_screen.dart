import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/core/common/widgets/app_bar_widget.dart';
import 'package:recipe/core/utils/string_constants.dart';
import 'package:recipe/features/recipe/presentation/provider/wishlist/wishlist_provider.dart';
import 'package:recipe/features/recipe/presentation/screens/components/recipe_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late WishListProvider provider;
  @override
  void initState() {
    super.initState();
    provider = Provider.of<WishListProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.getWishList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        appBattitle:StringConstants.wishlist,
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite,
              ))
        ],
      ),
      body: Consumer<WishListProvider>(builder: (context, recipeProvider, _) {
        return recipeProvider.wishList.isEmpty
            ? const Center(
                child: Text("No items in your wishlist"),
              )
            : RecipieCard(
                recipe: recipeProvider.wishList,
              );
      }),
    );
  }
}
