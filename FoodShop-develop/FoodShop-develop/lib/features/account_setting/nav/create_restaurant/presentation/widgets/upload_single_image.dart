import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/features/account_setting/nav/create_restaurant/presentation/controller/create_restaurant_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

// ignore: must_be_immutable
class UploadSingleImage extends GetView<CreateRestaurantController> {
  final bool circle;
  final VoidCallback getImage;
  final VoidCallback removeSingleImage;
  final File? display;
  double width;
  double height;
  final String id;

  UploadSingleImage(
      {super.key,
      this.circle = false,
      required this.getImage,
      required this.removeSingleImage,
      required this.display,
      this.width = double.infinity,
      this.height = 200,
      this.id = "fetchImageSetting"});

  @override
  Widget build(BuildContext context) {
    circle ? width = height : "";

    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        GetBuilder<CreateRestaurantController>(
            id: id,
            builder: (_) {
              File? images = display;
              return images != null
                  ? Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: height,
                          decoration: BoxDecoration(
                            shape:
                                circle ? BoxShape.circle : BoxShape.rectangle,
                            borderRadius:
                                circle ? null : BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.gray.withOpacity(0.1),
                              width: 2,
                            ),
                            image: DecorationImage(
                              image: FileImage(images),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () => removeSingleImage(),
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
                        getImage();
                      },
                      child: Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                          shape: circle ? BoxShape.circle : BoxShape.rectangle,
                          borderRadius:
                              circle ? null : BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.gray.withOpacity(0.1),
                            width: 2,
                          ),
                          color: AppColors.gray2,
                        ),
                        child: const Icon(
                          Icons.photo_camera_rounded,
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
