import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/routes/routes.dart';
import 'package:find_food/features/nav/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileAppbar extends StatelessWidget implements PreferredSizeWidget {
  final ProfileController controller;
  const ProfileAppbar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppBar(
        title: const Text("Profile"),
        actions: [
          controller.restaurant.value?.emailRestaurant != null
              ? IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.restaurant);
                  },
                  icon: const Icon(Icons.store_mall_directory_rounded),
                )
              : const SizedBox(),
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.accountSetting, arguments: {
                "restaurant": controller.restaurant.value?.emailRestaurant,
                "uid": controller.user?.uid ?? ""
              });
            },
            icon: const Icon(Icons.settings),
          ),
        ],
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.primary,
            height: 2.0,
          ),
        ),
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 2.0);
}
