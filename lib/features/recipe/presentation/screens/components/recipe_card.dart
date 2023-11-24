import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recipe/core/common/widgets/cached_network_image.dart';
import 'package:recipe/core/common/widgets/sized_box_widget.dart';
import 'package:recipe/core/config/route/route_path.dart';
import 'package:recipe/core/utils/constant_values.dart';
import 'package:recipe/core/utils/string_constants.dart';
import 'package:recipe/features/recipe/domain/entity/recipe_entity.dart';
import 'package:recipe/features/recipe/presentation/screens/recipe_details_screen.dart';

class RecipieCard extends StatelessWidget {
  final List<RecipeEntity> recipe;
  const RecipieCard({
    super.key, required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => SizedboxWidget(
          height: 20.h,
        ),
        shrinkWrap: true,
        itemCount: recipe.length,
        itemBuilder: (context, index) {
          final item=recipe[index];
          return Semantics(
            label: "${StringConstants.recipeCardClick}${item.title}",
            button: true,
            child: InkWell(
              onTap: () {
               
                context.go(RoutePath.recipeDetail,
                    extra: recipe[index]);
              },
              child: Column(
                children: [
                  CachedImageWidget(
                      width: 400.w,
                      height: 240,
                      imagePath: item.image ??
                          ""),
                  AppConstValues.text17(
                      item.title ??
                          ""),
                ],
              ),
            ),
          );
        },
      );
  }
}