import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:recipe/core/common/widgets/app_bar_widget.dart';
import 'package:recipe/core/config/route/route_path.dart';
import 'package:recipe/core/utils/app_constant_widgets.dart';
import 'package:recipe/core/utils/string_constants.dart';
import 'package:recipe/features/recipe/presentation/provider/recipe/recipe_provider.dart';
import 'package:recipe/features/recipe/presentation/provider/wishlist/wishlist_provider.dart';
import 'package:recipe/features/recipe/presentation/screens/components/recipe_card.dart';
import 'package:recipe/features/recipe/presentation/screens/wishlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late RecipeProvider provider;

  @override
  void initState() {
    super.initState();

    provider = Provider.of<RecipeProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<WishListProvider>(context, listen: false).syncData();
      provider.getRecipe();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        appBattitle: StringConstants.appname,
        leading: const Icon(Icons.menu),
        actions: [
          Semantics(
            button: true,
            label: StringConstants.navigateToWishList,
            child: IconButton(
                onPressed: () {
                  context.go(
                    RoutePath.wishList,
                  );
                },
                icon: const Icon(
                  Icons.favorite,
                )),
          )
        ],
      ),
      body: Consumer<RecipeProvider>(builder: (context, recipeProvider, _) {
        return recipeProvider.loading
            ? Center(
                child: AppConstWidget.circularProgressIndicator(),
              )
            : recipeProvider.errorMessage.isNotEmpty
                ? Center(
                    child: Text(recipeProvider.errorMessage),
                  )
                : recipeProvider.recipeList.isEmpty
                    ? const SizedBox()
                    : RecipieCard(
                        recipe: recipeProvider.recipeList,
                      );
      }),
    );
  }
}
