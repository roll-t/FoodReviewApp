import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/configs/app_dimens.dart';
import 'package:find_food/features/find_post/category/presentation/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavControllList extends GetView<CategoryController> {
  final int currentIndex;
  final Function(int) onPageChanged;

  const NavControllList({
    super.key,
    required this.currentIndex,
    required this.onPageChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: Get.width*0.035,right: Get.width*0.035,top: 10),
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
              Flexible(child: itemNav(title: "Area", index: 0)),
              Flexible(child: itemNav(title: "Favorite", index: 1)),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }

  Widget itemNav({required String title, required int index}) {
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
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? AppColors.black : AppColors.gray,
              fontWeight: isActive ? FontWeight.w400: FontWeight.w500,
              fontSize: AppDimens.textSize22
            ),
          ),
        );
      }),
    );
  }
}
