import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recipe/core/common/widgets/app_bar_widget.dart';
import 'package:recipe/core/common/widgets/cached_network_image.dart';
import 'package:recipe/core/common/widgets/sized_box_widget.dart';

import 'package:recipe/core/utils/constant_values.dart';
import 'package:recipe/core/utils/string_constants.dart';
import 'package:recipe/features/recipe/domain/entity/recipe_entity.dart';
import 'package:recipe/features/recipe/presentation/provider/text_to_speech/text_to_speech_provider.dart';
import 'package:recipe/features/recipe/presentation/provider/wishlist/wishlist_provider.dart';
import 'package:recipe/features/recipe/presentation/screens/components/action_button.dart';

class RecipeDetail extends StatelessWidget {
  final RecipeEntity recipe;
  const RecipeDetail({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final WishListProvider wishListProvider =
        Provider.of<WishListProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBarWidget(
        appBattitle: recipe.title!,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppConstValues.horizontah10),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  CachedImageWidget(imagePath: recipe.image ?? ""),
                  AppConstValues.text17(recipe.title ?? ""),
                  AppConstValues.textSub(recipe.description ?? ""),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Semantics(
                    button: true,
                    label: StringConstants.addToWishList,
                    child: ActionButton(
                      title: StringConstants.addToWishList,
                      icon: Icons.favorite,
                      onPressed: () {
                        wishListProvider.addWishList(recipe);
                      },
                    ),
                  ),
                ),
                SizedboxWidget(
                  width: 10.w,
                ),
                Expanded(
                  child: Semantics(
                    button: true,
                    label: StringConstants.tapToSpeakRecipe,
                    child: ActionButton(
                      title: StringConstants.speaker,
                      icon: Icons.volume_up_sharp,
                      onPressed: () async {
                        if (recipe.description != null) {
                          Provider.of<TextToSpeechProvider>(context,
                                  listen: false)
                              .textToSpeech(text: recipe.description!);
                        }
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
