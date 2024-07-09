import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';

class AppbaPostsDetails extends StatelessWidget implements PreferredSizeWidget {
  const AppbaPostsDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 7),
      child: Column(
        children: [
          AppBar(
            title: const TextWidget(text: "DETAIL"),
            centerTitle: true,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            height: 1,
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
          )
        ],
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 7);
}
