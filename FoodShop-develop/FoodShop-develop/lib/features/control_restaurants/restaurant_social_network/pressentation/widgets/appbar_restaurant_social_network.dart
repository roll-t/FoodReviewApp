import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';

class buildAppbarRestaurantSocialNetwork extends StatelessWidget
    implements PreferredSizeWidget {
  const buildAppbarRestaurantSocialNetwork({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(5),
        child: Container(
          color: AppColors.primary,
          height: 5,
        ),
      ),
      title: const TextWidget(
        text: "Social Account Setting",
        color: AppColors.primary,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
