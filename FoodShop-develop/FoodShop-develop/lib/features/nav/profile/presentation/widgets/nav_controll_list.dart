import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/features/nav/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavControllList extends GetView<ProfileController> {
  final int currentIndex;
  final Function(int) onPageChanged;

  const NavControllList({
    Key? key,
    required this.currentIndex,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: AppColors.gray,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: itemNav(icon: Icons.list, index: 0)),
              Flexible(child: itemNav(icon: Icons.favorite_border, index: 1)),
              Flexible(child: itemNav(icon: Icons.bookmark_outline, index: 2)),
              Flexible(child: itemNav(icon: Icons.lock_outline, index: 3)),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }

  Widget itemNav({required IconData icon, required int index}) {
    return GestureDetector(
      onTap: () {
        controller.onChangeNavList(index);
      },
      child: Obx(() {
        bool isActive = controller.currentIndex.value == index;
        return Container(
          decoration: BoxDecoration(
            border: isActive
                ? const Border(
                    bottom: BorderSide(width: 2, color: AppColors.black))
                : null,
          ),
          padding: const EdgeInsets.only(left: 25, right: 25, bottom: 5),
          child: Icon(
            icon,
            size: 40,
            color: isActive ? AppColors.black : AppColors.gray,
          ),
        );
      }),
    );
  }
}
