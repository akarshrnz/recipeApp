

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/common/widgets/text_widget.dart';
import 'package:recipe/core/utils/color_constant.dart';


class AppConstValues {
  static double horizontalMarginMobile = 10.w;
  static double horizontalMarginTab = 100;
  static double verticalMarginMobile = 30;
  static double verticalMarginTab = 60;

    static double vertical10 = 10.0.h;
     static double horizontah10 = 10.0.w;
      static double horizontah20 = 20.0.w;

  static TextWidget text17(String title) {
    return TextWidget(
      data: title,
      style: TextStyle(
          color: ColorConstant.textColor,
          fontWeight: FontWeight.bold,
          fontSize: 17.sp),
    );
  }
    static TextWidget textSub(String title) {
    return TextWidget(
      data: title,
      style: TextStyle(
          color: ColorConstant.textColor,
          fontWeight: FontWeight.w500,
          fontSize: 15
         ),
    );
  }
   static TextWidget textSubtitle(String title) {
    return TextWidget(
      data: title,
      style: TextStyle(
          color: ColorConstant.whiteColor,
          fontWeight: FontWeight.w500,
          ),
    );
  }
  
}
