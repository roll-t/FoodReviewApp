import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/configs/app_dimens.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppbarRestaurantSetting extends StatelessWidget
    implements PreferredSizeWidget {
  const AppbarRestaurantSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const TextWidget(
        text: "Restaurant Setting",
        color: AppColors.primary,
        size: AppDimens.textSize24,
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(5.0),
        child: Container(
          color: AppColors.primary,
          height: 5.0,
        ),
      ),
      leading: IconButton(
        color: AppColors.primary,
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
