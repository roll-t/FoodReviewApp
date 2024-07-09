import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/configs/app_dimens.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildAppbarRestaurantChangeInfor extends StatelessWidget
    implements PreferredSizeWidget {
  const BuildAppbarRestaurantChangeInfor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5),
          child: Container(
            color: AppColors.primary,
            height: 2,
          )),
      title: const TextWidget(
        text: "Restaurant Setting",
        color: AppColors.primary,
        size: AppDimens.textSize24,
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.primary,
        ),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
