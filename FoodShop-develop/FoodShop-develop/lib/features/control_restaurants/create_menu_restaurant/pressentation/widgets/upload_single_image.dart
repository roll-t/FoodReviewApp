import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/features/control_restaurants/create_menu_restaurant/pressentation/controller/create_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadSingleImage extends GetView<CreateMenuController> {
  const UploadSingleImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Obx(() {
          return controller.imageFood.value != null
              ? Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.gray.withOpacity(0.1),
                          width: 2,
                        ),
                        image: DecorationImage(
                          image: FileImage(controller.imageFood.value!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () => controller.removeSingleImage(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.gray.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : GestureDetector(
                  onTap: () {
                    controller.pickImage();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.gray.withOpacity(0.1),
                        width: 2,
                      ),
                      color: AppColors.gray2,
                    ),
                    child: const Icon(
                      Icons.fastfood_rounded,
                      size: 100,
                    ),
                  ),
                );
        }),
        const SizedBox(height: 10),
      ],
    );
  }
}
