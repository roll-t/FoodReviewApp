import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/features/account_setting/nav/create_restaurant/presentation/controller/create_restaurant_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class UploadImage extends GetView<CreateRestaurantController> {
  List images;
  UploadImage({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          return Wrap(
            spacing: 15,
            runSpacing: 15,
            children: images.map((image) {
              return Stack(
                children: [
                  Image.file(
                    image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => controller.removeImage(images, image),
                      child: Container(
                        color: Colors.red,
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        }),
        GestureDetector(
          onTap: () {
            controller.pickImages(images);
          },
          child: Obx(
            () => Container(
              margin: const EdgeInsets.only(top: 10),
              width: double.infinity,
              height: controller.check_list_empty(images) ? 180 : 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.gray.withOpacity(0.1),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.gray2,
              ),
              child: controller.check_list_empty(images)
                  ? const Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 100,
                    )
                  : const Icon(Icons.add, size: 40),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
