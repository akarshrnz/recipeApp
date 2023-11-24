import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe/core/utils/color_constant.dart';


class CachedImageWidget extends StatelessWidget {
  final String imagePath;
  final double ?height;
  final double? width;
  const CachedImageWidget(
      {super.key, required this.imagePath,  this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,height: height,
      fit: BoxFit.fill,
      imageUrl:imagePath,
      placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(color: ColorConstant.red)),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
