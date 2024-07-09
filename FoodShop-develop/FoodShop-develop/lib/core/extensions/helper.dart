import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/configs/app_dimens.dart';
import 'package:flutter/material.dart';

class CustomShadow {
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: AppColors.gray.withOpacity(.2),
          blurRadius: 2,
          spreadRadius: .7,
          offset: const Offset(0, 1),
        ),
      ];
}

class CustomCardStyle {
  static BoxDecoration get cardBoxDecoration => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimens.radius1),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray.withOpacity(.2),
              blurRadius: 2,
              spreadRadius: .7,
              offset: const Offset(0, 1),
            ),
          ]);
}
